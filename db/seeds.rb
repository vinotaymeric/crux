require 'json'
require 'open-uri'
require 'nokogiri'
require_relative 'lib/seed_functions'
require_relative 'lib/bra_functions'
require_relative 'lib/basecamp'
require 'date'
require 'pry'
require "base64"


# Weather.all.each do |weather|
#   begin
#   next if weather.forecast != nil
#   area = weather.area
#   # p weather_api_call(area.coord_lat, area.coord_long)
#   weather_hash = weather_api_call(area.coord_lat, area.coord_long)
#   weather.forecast = weather_hash["forecast"]["forecastday"]
#   weather.save!
#   p weather.id
#   rescue Exception => e
#   puts e.message
#   end
# end

Itinerary.all.each do |itinerary|
  next if itinerary.difficulty != nil
  begin
  itinerary_hash = api_call("routes", itinerary.source_id)
  itinerary.update!(difficulty: itinerary_hash["global_rating"])
  itinerary.update!(universal_difficulty: itinerary.universal_difficulty)
  itinerary.update_recent_conditions
  p itinerary.id
  sleep(0.1)
  rescue Exception => e
  p e.message
  end
end
