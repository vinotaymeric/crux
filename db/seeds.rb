# require_relative 'bra_functions'
require_relative 'lib/basecamp'
# require 'json'
# require 'open-uri'
# require 'nokogiri'
# require 'date'
# require 'date'
# require 'pry'
# require "base64"

# # Delete all


# BasecampsActivitiesItinerary.delete_all
# BasecampsActivity.delete_all
# Basecamp.delete_all
# MountainRange.delete_all
# Weather.delete_all


# puts "###Seeding MountainRange#### "

# ## initilization of mountainRange
# puts "initilization of mountainRange"

# RANGES.each do |range|
#   MountainRange.create!(
#     name: range[0],
#     coord_lat: range[2],
#     coord_long: range[3]
#     )
# end

# ######
# date = 20190220

# update_mountain_ranges(date)

# puts "####MountainRange seeding completed###"

# ## SEED BASECAMPS
# puts "Seeding basecamps..."
# NB_INHAB = 500 # Change this param if needed
# SCOPE_DEPARTMENTS = %w[74 38 73 04 05 06].freeze # Change this param if needed
# MAX_DIST_FROM_MOUNTAIN_RANGE = 80 # max distance (km) between a mountain_range and a basecamp

# cities = csv_to_cities('db/csv_repos/french_cities.csv')
# cities = filter_on_cities(cities, NB_INHAB, SCOPE_DEPARTMENTS)
# feed_basecamps(cities, MAX_DIST_FROM_MOUNTAIN_RANGE)

# puts "Basecamps seeding completed"

# ## SEED BASECAMPS_ACTIVITIES
# Basecamp.all.each do |basecamp|
#   Activity.all[0..2].each do |activity|
#     BasecampsActivity.create!(basecamp: basecamp, activity: activity)
#   end
# end

# ## SEED BASECAMPS_ACTIVITIES_ITINERARIES

# BasecampsActivity.all.each do |basecamps_activity|
#     p basecamps_activity.id
#   Itinerary.all.each do |itinerary|
#     if itinerary.activity == basecamps_activity.activity && itinerary.distance_from(basecamps_activity.basecamp) < 15
#       BasecampsActivitiesItinerary.create!(itinerary_id: itinerary.id, basecamps_activity_id: basecamps_activity.id)
#     end
#   end
# end

# ## Initiate weather

# puts "initilization of weather..."

# Weather.destroy_all

# BasecampsActivity.where(activity_id: 13).each do |basecamp_activity|
#   Weather.create!(basecamp: basecamp_activity.basecamp)
# end

# def api_call(lat, lon)
#   url = "https://api.apixu.com/v1/forecast.json?key=3a0aef724b764f6cb35161705192702&q=#{lat},#{lon}&days=7"
#   JSON.parse(open(url).read)
# end

# Weather.all.each do |weather|
#   begin
#   basecamp = weather.basecamp
#   weather_hash = api_call(basecamp.coord_lat, basecamp.coord_long)
#   p weather_hash
#   score = 0

#   weather_hash["forecast"]["forecastday"].each do |day|
#     day_hash = day["day"]
#     score += day_hash["avgtemp_c"].to_i + day_hash["avgvis_km"].to_i - day_hash["maxwind_kph"].to_i - day_hash["totalprecip_mm"].to_i
#   end
#   weather.weekend_score = score
#   weather.forecast = weather_hash["forecast"]["forecastday"]
#   weather.save!

#   # Adding a rescue so that it works even a call fails

#   rescue Exception => e
#   puts "#weather {weather.id} a pété"
#   end

# end

# # Update iti levels

# Itinerary.all.each do |itinerary|
#   expérimenté = ["TD-", "TD", "TD+", "ED-", "ED", "ED+"]
#   intermediaire = ["D-", "D", "D+", "AD-", "AD", "AD+"]
#   débutant = ["PD-", "PD", "PD+", "F-", "F", "F+"]
#   if expérimenté.include?(itinerary.difficulty)
#     itinerary.level = "Expérimenté"
#   elsif intermediaire.include?(itinerary.difficulty)
#     itinerary.level = "Intermédiaire"
#   elsif débutant.include?(itinerary.difficulty)
#     itinerary.level = "Débutant"
#   end
#   itinerary.save!
#   p itinerary.id
# end


# Add code_insee to Basecamp

# cities_db = csv_to_cities('db/csv_repos/french_cities.csv')

# Basecamp.all.each do |basecamp|
#   city = cities_db.select { |item| (item[:name] == basecamp.name) && item[:coord_lat] == basecamp.coord_lat }[0]
#   basecamp.code_insee = city[:code_insee]
#   p basecamp.code_insee
#   basecamp.save!
# end


# Add geoname_id to Basecamp

geonames_db = csv_to_geoname_ids('db/csv_repos/geoname_ids_france.csv')
Basecamp.all.each do |basecamp|
  geoname_infos = geonames_db.select { |item| p item[:code_insee] == basecamp.code_insee }
  p geoname_infos
end
