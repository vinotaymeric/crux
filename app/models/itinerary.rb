require "objspace"

class Itinerary < ApplicationRecord
  belongs_to :activity
  belongs_to :basecamp
  belongs_to :hut, optional: true
  has_many :favorite_itineraries
  has_many :trips, through: :favorite_itinerary
  has_many :outings
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long

  def api_call(itinerary, id)
    url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
    JSON.parse(open(url).read)
  end

  def short_name
    name.size > 50 ? name[0..50] + "..." : name
  end

  def update_recent_conditions
    api_call("routes", source_id)["associations"]["recent_outings"]["documents"].each do |outing|
      begin
        date = Date.parse outing["date_start"]

        if date.upto(Date.today).to_a.size < 60000
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
      rescue StandardError => e
        puts e.message
      end
    end
  end

  def recent_outings(days_to_look_back = 60)
    recent_outings = outings.map do |outing|
      [outing.date, outing.content] if (Date.today - Date.parse(outing.date)) < days_to_look_back
    end

    recent_outings.compact.sort_by! {|outing| outing[0]}.reverse
  end

  def universal_difficulty
    expérimenté = ["TD-", "TD", "TD+", "ED-", "ED", "ED+", "T5", "5.5","5.4","5.3","5.2","5.1","4.3","4.2", "S5"]
    intermédiaire = ["D-", "D", "D+", "AD-", "AD", "AD+", "T4", "T3", "4.1", "3.3", "3.2", "3.1", "S4", "S3"]
    débutant = ["PD-", "PD", "PD+", "F-", "F", "F+", "T2", "T1", "2.3", "2.2", "2.1", "1.3", "1.2", "1.1", "S2", "S1"]

    if difficulty != nil
      technical_difficulty = difficulty
    elsif hiking_rating != nil
      technical_difficulty = hiking_rating
    elsif ski_rating != nil
      technical_difficulty = ski_rating
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

  def small_picture
    if picture_url[-3..-1] == "svg"
      "#{picture_url[0..-5]}MI.jpg"
    else
      "#{picture_url[0..-5]}MI.#{picture_url[-3..-1]}"
    end
  end

  def picture_url_p
    placeholder = "https://res.cloudinary.com/dbehokgcg/image/upload/v1553511342/placeholder.png"
    picture_url.nil? ? placeholder : small_picture
  end

  def outing_months
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

  def guessed_outing_months
    outing_months.map do |key, value|
      if key == 1
        (outing_months[12] > 0 && outing_months[2] > 0 && value == 0) ? value = 1  : value
      elsif key == 12
        (outing_months[11] > 0 && outing_months[1] > 0 && value == 0) ? value = 1  : value
      else
        (outing_months[key - 1] > 0 && outing_months[key + 1] > 0 && value == 0) ? value = 1  : value
      end
    end
  end

  def is_incomplete?
    height_diff_up.nil? || elevation_max.nil? || orientations.nil?
  end

  def activity_score
    return 0 if is_incomplete?

    month = Date.today.month
    activity = activity.name

    average_elevation = elevation_max - (height_diff_up / 2)

    winter_months = [12, 1, 2, 3]
    intermediate_months = [11, 4, 5]
    ski_months = [11, 12, 1, 2, 3, 4, 5]
    activity_score = 1

    if activity == "rock_climbing" && winter_months.include?(month) && (average_elevation > 1200 || orientations.include?("N"))
      activity_score = 0
    elsif activity == "rock_climbing" && intermediate_months.include?(month) && (average_elevation > 2000 || orientations.include?("N"))
      activity_score = 0
    elsif activity == "skitouring" && !ski_months.include?(month)
      activity_score = 0
    elsif activity == "skitouring" && intermediate_months.include?(month) && average_elevation < 2500 && orientations.include?("S")
      activity_score = 0
    elsif activity == "skitouring" && intermediate_months.include?(month) && average_elevation < 1750
      activity_score = 0
    elsif activity == "hiking" && ski_months.include?(month) && average_elevation > 1000
      activity_score = 0
    end

    activity_score
  end

  def score_calculation
    picture_url.nil? ? score = 0.19 : score = 0.2
    score = score / 2 if (number_of_outing + outings.count) < 2
    score = score / 2 if content.nil? || content.size < 500
    outing_months[Date.today.month] > 0 ? score *= 5 : score = score * activity_score
    score
  end

  def clean_content
    content.gsub(/\[(.*?)\]/) {|tag| tag.split("|")[1] }.gsub("[","").gsub("]","")
  end
end
