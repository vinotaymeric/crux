require 'json'
require 'open-uri'

class UpdateWeather

  def api_call(lat, lon)
    url = "https://api.apixu.com/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat},#{lon}&days=7"
    JSON.parse(open(url).read)
  end

  def update_weather
    Weather.all.each do |weather|
      begin
      city = weather.cities[0]
      next if city.nil?
      p weather.id
      weather_hash = api_call(city.coord_lat, city.coord_long)
      weather.forecast = weather_hash["forecast"]["forecastday"]
      weather.save!
      rescue Exception => e
      puts e.message
      end
    end
  end

end
