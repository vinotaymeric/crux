class BasecampsActivity < ApplicationRecord
  # belongs_to :activity
  belongs_to :activity
  belongs_to :basecamp
  has_many :trips
  has_one :weather, :through => :basecamp
  has_many :basecamps_activities_itineraries
  has_many :itineraries, through: :basecamps_activities_itineraries

  def weather_icons(trip)
    icons = []
    start_date = trip.start_date
    end_date = trip.end_date
    weather = self.basecamp.weather

    start_date.upto(end_date) do |date|
      weather.forecast.each do |forecast|
        icons << forecast["day"]["condition"]["icon"].to_s if (Date.parse forecast["date"]) == date
      end
    end
    return icons
  end
end
