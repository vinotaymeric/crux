class Area < ApplicationRecord
  has_many :basecamps, dependent: :nullify
  has_many :itineraries, through: :basecamps
  belongs_to :weather, optional: true
  belongs_to :city, optional: true
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long

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
