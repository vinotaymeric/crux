require "objspace"

class Itinerary < ApplicationRecord
  belongs_to :activity
  belongs_to :basecamp
  belongs_to :hut, optional: true
  has_many :favorite_itineraries
  has_many :trips, through: :favorite_itinerary
  has_many :basecamps_activities_itineraries
  has_many :basecamps_activities, through: :basecamps_activities_itineraries
  has_many :outings
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
  self.per_page = 3

  # PG search is to slow
  # include PgSearch
  #   pg_search_scope :search_by_name_and_content,
  #     against: [ :name, :content ],
  #     using: {
  #       tsearch: { prefix: true }
  #     }

  def api_call(itinerary, id)
    url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
    begin
    JSON.parse(open(url).read)
    rescue Exception => e
    end
  end

  def short_name
    if self.name.size > 50
      name = self.name[0..50] + "..."
    else
      name = self.name
    end
    return name
  end

  def update_recent_conditions
    begin
    api_call("routes", self.source_id)["associations"]["recent_outings"]["documents"].each do |outing|
      date = Date.parse outing["date_start"]

      if date.upto(Date.today).to_a.size < 60
        document_id = outing["document_id"]
        saved_outing = Outing.find_by(source_id: document_id)
        if saved_outing.nil?
          saved_outing = Outing.create!(itinerary: self, date: outing["date_start"], source_id: outing["document_id"])
        end
        recap = api_call("outings", document_id)["locales"][0]
        content = ""
        content += recap["timing"] if recap["timing"] != nil
        content += "\n #{recap["route_description"]}" if recap["route_description"] != nil
        content += "\n #{recap["conditions"]}" if recap["conditions"] != nil
        content += "\n #{recap["description"]}" if recap["description"] != nil
        saved_outing.update!(content: content)
      end
    end
    rescue
    end
  end

  def recent_outings
    outings = self.outings
    recent_outings = []
    outings.each do |outing|
      date = Date.parse outing.date
      if date.upto(Date.today).to_a.size < 60
        recent_outings << [outing.date, outing.content]
      end
    end
    recent_outings.sort_by! {|outing| outing[0]}.reverse
  end

  def universal_difficulty
    expérimenté = ["TD-", "TD", "TD+", "ED-", "ED", "ED+", "T5", "5.5","5.4","5.3","5.2","5.1","4.3","4.2", "S5"]
    intermédiaire = ["D-", "D", "D+", "AD-", "AD", "AD+", "T4", "T3", "4.1", "3.3", "3.2", "3.1", "S4", "S3"]
    débutant = ["PD-", "PD", "PD+", "F-", "F", "F+", "T2", "T1", "2.3", "2.2", "2.1", "1.3", "1.2", "1.1", "S2", "S1"]

    if self.difficulty != nil
      technical_difficulty = self.difficulty
    elsif self.hiking_rating != nil
      technical_difficulty = self.hiking_rating
    elsif self.ski_rating != nil
      technical_difficulty = self.ski_rating
    end

    if expérimenté.include?(technical_difficulty)
      universal_difficulty = "expérimenté"
    elsif intermédiaire.include?(technical_difficulty)
      universal_difficulty = "intermédiaire"
    elsif débutant.include?(technical_difficulty)
      universal_difficulty = "débutant"
    else
      universal_difficulty = nil
    end
    universal_difficulty
  end

  def picture_url_p
    placeholder = "https://res.cloudinary.com/dbehokgcg/image/upload/v1553511342/placeholder.png"
    self.picture_url.nil? ? placeholder : "#{self.picture_url[0..-5]}MI.jpg"
  end

  def outing_months
    outings = self.outings
    outings_per_month = {
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0,
      6 => 0,
      7 => 0,
      8 => 0,
      9 => 0,
      10 => 0,
      11 => 0,
      12 => 0
    }
    outings.each do |outing|
      next if outing.date.nil?
      month = outing.date.split("-")[1].to_i
      outings_per_month[month] += 1
    end

    outings_per_month
  end

  def score
    self.picture_url.nil? ? score = 0.3 : score = 1
    score = score / 3 if (self.number_of_outing + self.outings.count) < 2
    score = score / 3 if self.content.nil? || self.content.size < 500
    score *= 5 if self.outing_months[Date.today.month] > 0
    return score
  end

  def clean_content
    content = self.content
    content.gsub(/\[(.*?)\]/) {|tag| tag.split("|")[1] }.gsub("[","").gsub("]","")
  end
end
