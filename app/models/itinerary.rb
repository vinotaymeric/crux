require "objspace"
require "addressable"

class Itinerary < ApplicationRecord

  include AlgoliaSearch
  algoliasearch if: :small? do
  end

  belongs_to :activity
  has_many :favorite_itineraries
  has_many :trips, through: :favorite_itinerary
  has_many :basecamps_activities_itineraries
  has_many :basecamps_activities, through: :basecamps_activities_itineraries
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
  self.per_page = 3

  def small?
    ObjectSpace.memsize_of(content.to_json) < 10000
  end

  def api_call(itinerary, id)
    url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
    begin
    JSON.parse(open(url).read)
    rescue Exception => e
    end
  end

  def recent_conditions
    itinerary = Addressable::URI.encode_component(self.name, Addressable::URI::CharacterClasses::QUERY)
    url_c2C = "https://www.google.fr/search?ei=8gmBXLvLGOCCjLsPsf2_gAo&q=site%3Ahttps%3A%2F%2Fwww.camptocamp.org%2Froutes%2F+#{itinerary}+&oq=site%3Ahttps%3A%2F%2Fwww.camptocamp.org%2Froutes%2F+#{itinerary}"

    html_file_c2C = open(url_c2C).read
    html_doc_c2c = Nokogiri::HTML(html_file_c2C)

    id = html_doc_c2c.search('h3').first.children.attribute('href').value.split("/")[5].to_i

    outing_ids = []
    return if api_call("outings", id).nil?
    api_call("outings", id)["associations"]["recent_outings"]["documents"].each do |outing|
      date = Date.parse outing["date_end"]
      if date.upto(Date.today).to_a.size < 60
        outing_ids << [outing["document_id"].to_i, outing["date_end"].to_s]
      end
    end
    outing_ids
  end

end
