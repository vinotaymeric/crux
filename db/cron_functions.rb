require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'

def api_call(lat, lon)
  url = "https://api.apixu.com/v1/forecast.json?key=3a0aef724b764f6cb35161705192702&q=#{lat},#{lon}&days=7"
  JSON.parse(open(url).read)
end

def update_weather
  Weather.all.each do |weather|
    begin
    basecamp = weather.basecamp
    weather_hash = api_call(basecamp.coord_lat, basecamp.coord_long)
    score = 0
    weather_hash["forecast"]["forecastday"].each do |day|
      day_hash = day["day"]
      score += day_hash["avgtemp_c"].to_i + day_hash["avgvis_km"].to_i - day_hash["maxwind_kph"].to_i - day_hash["totalprecip_mm"].to_i
    end
    weather.weekend_score = score
    weather.forecast = weather_hash["forecast"]["forecastday"]
    weather.save!

    # Adding a rescue so that it works even a call fails

    rescue Exception => e
    puts "#weather {weather.id} a pété"
    end
  end
end

