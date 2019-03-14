require 'json'
require 'open-uri'
require 'nokogiri'
require_relative 'lib/seed_functions'
require_relative 'lib/bra_functions'
require_relative 'lib/basecamp'
require 'date'
require "base64"

# BasecampsActivitiesItinerary.delete_all
# FavoriteItinerary.delete_all
# Trip.delete_all
# BasecampsActivity.delete_all
# Itinerary.delete_all
# Basecamp.delete_all
# Area.delete_all
# Weather.delete_all
# UserActivity.delete_all
# Activity.delete_all
# User.delete_all
City.delete_all
MountainRange.delete_all

RANGES.each do |range|
  MountainRange.create!(
    name: range[0],
    coord_lat: range[2],
    coord_long: range[3]
    )
end

date = 20190220
##bra de tous les ranges
bra_ranges = bra_all_ranges_per_date(date)

p "nbr de bra #{bra_ranges.length}, date  #{date}}"

bra_ranges.each do |bra_range|

  MountainRange.create!(
    name: bra_range[:range_name],
    bra_date: bra_range[:bra_date_validity],
    rosace_url: bra_range[:rosace_image_url],
    fresh_snow_url: bra_range[:fresh_snow_image_url],
    snow_image_url: bra_range[:snow_image_url],
    snow_quality: bra_range[:snow_quality],
    stability: bra_range[:stability]
    )
end

puts "####MountainRange seeding completed###"

## SEED cities
puts "Seeding cities..."
NB_INHAB = 0 # Change this param if needed
SCOPE_DEPARTMENTS = %w[].freeze # Change this param if needed
MAX_DIST_FROM_MOUNTAIN_RANGE = 80 # max distance (km) between a mountain_range and a basecamp

cities = csv_to_cities('db/csv_repos/french_cities.csv')
cities = filter_on_cities(cities, NB_INHAB, SCOPE_DEPARTMENTS)
feed_cities(cities, MAX_DIST_FROM_MOUNTAIN_RANGE)

puts "cities seeding completed"

# Add geoname_id to cities
geonames_db = csv_to_geoname_ids('db/csv_repos/geoname_ids_france_order_pop.csv')

City.all.each do |city|
  next if city.geoname != nil
  begin
  geoname_infos = geonames_db.select { |item| item[:code_insee] == city.code_insee }[0]
  city.geoname = geoname_infos[:geoname_id]
  p city.geoname
  city.save!
  rescue Exception => e
  puts e.message
  end
end

# Add geoname_id to cities
geonames_db = csv_to_geoname_ids('db/csv_repos/geoname_ids_france_order_pop.csv')

City.all.each do |city|
  next if city.geoname != nil
  begin
  geoname_infos = geonames_db.select { |item| item[:code_insee] == city.code_insee }[0]
  city.geoname = geoname_infos[:geoname_id]
  p city.geoname
  city.save!
  rescue Exception => e
  puts e.message
  end
end

