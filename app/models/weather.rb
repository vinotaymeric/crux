class Weather < ApplicationRecord
  has_many :cities
  has_many :itineraries, through: :areas

  def score(start_date, end_date)
    return if self.forecast.nil?
    weather_score = 0
    start_date.upto(end_date) do |date|
      self.forecast.each do |forecast|
        weather_score += weather_day_score(forecast) if (Date.parse forecast["date"]) == date
      end
    end
    weather_score = [weather_score, 0.5].max
  end

  private

  def weather_day_score(forecast)
    if forecast["day"]["maxwind_kph"] < 50 && forecast["day"]["totalprecip_mm"] < 2 && forecast["day"]["avgvis_km"] > 5
      day_score = 1
    else
      day_score = -1
    end
    return day_score
  end
end
