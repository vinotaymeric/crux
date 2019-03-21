require 'json'
require 'open-uri'
require 'nokogiri'
require_relative 'lib/seed_functions'
require_relative 'lib/bra_functions'
require_relative 'lib/basecamp'
require 'date'
require 'pry'
require "base64"

# db_areas = Area.where.not(coord_long: nil)

# db_areas.each do |area|
#   next if area.weather != nil
#   p area.id

#   closest_area = db_areas.where.not(id: area.id, weather_id: nil).sort_by { |area2| area2.distance_from(area) }[0]
#   # p area.distance_from(closest_area)
#   if area.distance_from(closest_area) > 50 || closest_area.nil?
#     weather = Weather.new()
#     area.update!(weather: weather)
#   else
#     area.update!(weather: closest_area.weather)
#   end

# end


# Weather.all.each do |weather|
#   begin
#   next if weather.forecast != nil

#   area = weather.areas[0]
#   # p weather_api_call(area.coord_lat, area.coord_long)
#   weather_hash = weather_api_call(area.coord_lat, area.coord_long)
#   weather.forecast = weather_hash["forecast"]["forecastday"]
#   weather.save!
#   rescue Exception => e
#   puts e.message
#   end
# end

# City.all.each do |city|
#   begin
#   next if city.areas == nil
#   next if city.areas[0].weather_id == nil
#   weather_id = city.areas[0].weather_id
#   p weather_id
#   weather = Weather.find(weather_id)
#   city.update!(weather: weather)
#   p city.id
#   rescue Exception => e
#   puts e.message
#   end
# end

# Itinerary.all.each do |itinerary|
#   next if itinerary.difficulty != nil
#   begin
#   itinerary_hash = api_call("routes", itinerary.source_id)
#   itinerary.update!(difficulty: itinerary_hash["global_rating"])
#   itinerary.update!(universal_difficulty: itinerary.universal_difficulty)
#   itinerary.update_recent_conditions
#   p itinerary.id
#   sleep(0.1)
#   rescue Exception => e
#   p e.message
#   end
# end

# Cloudinary::Uploader.upload("https://media.camptocamp.org/c2corg-active/1540615817_369858027.png",
#   :public_id => "toto", :overwrite => true)
