require "open-uri"
require "nokogiri"

class Basecamp < ApplicationRecord
  has_many :basecamps_activities
  belongs_to :weather, optional: true
  # has_many :trips, through: :trips_basecamps
  # has_many :itineraries, through: :basecamps_itineraries
  belongs_to :mountain_range, optional: true
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long

  def meteoblue_air_url
    url = "https://www.meteoblue.com/fr/meteo/prevision/air/_france_#{self.geoname}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    meteoblue_15min_valid_path = doc.search('#blooimage').search('img').attr('data-original').value
    "https://#{meteoblue_15min_valid_path}"
  end

  def meteoblue_semaine_url
    url = "https://www.meteoblue.com/fr/meteo/prevision/semaine/_france_#{self.geoname}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    meteoblue_15min_valid_path = doc.search('.bloo_content').children[2].attr('data-original')
    "https://#{meteoblue_15min_valid_path}"
  end

end
