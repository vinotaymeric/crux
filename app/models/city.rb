class City < ApplicationRecord
  attr_accessor :nb_itineraries, :nb_good_itineraries
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long
  belongs_to :mountain_range, optional: true
  belongs_to :weather, optional: true
  has_many :areas
  has_many :itineraries, through: :areas

  def clean_name
    self.name.encode("iso-8859-1").force_encoding("utf-8")
  end

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

  def weather_icons(trip)
    icons = []
    start_date = trip.start_date
    end_date = trip.end_date
    weather = self.weather
    # Ligne ci dessous à enlver une fois le seed de weather fait
    return ["//cdn.apixu.com/weather/64x64/day/296.png"] if weather.nil?

    start_date.upto(end_date) do |date|
      weather.forecast.each do |forecast|
        icons << forecast["day"]["condition"]["icon"].to_s if (Date.parse forecast["date"]) == date
      end
    end
    return icons
  end
end
