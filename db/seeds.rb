require_relative 'bra_functions'
require_relative 'lib/basecamp'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'date'
require 'pry'
require "base64"

# puts "Seeding Activities..."

if Activity.count == 0
  Activity.create!(name: "ski de randonnée")
  Activity.create!(name: "alpinisme")
  Activity.create!(name: "escalade")
  Activity.create!(name: "cascade de glace")
end


## SEED FAKE USERS
puts "Seeding users..."

User.destroy_all

User.create!(email: "nico@crux.io", password: "qwertyuiop")
User.create!(email: "aymeric@crux.io", password: "azerty")
User.create!(email: "ouramadane@crux.io", password: "qwertyuiop")
User.create!(email: "jordi@crux.io", password: "qwertyuiop")

puts "User seeding completed"


## SEED RANGES
puts "###Seeding MountainRange#### "
#MountainRange.destroy_all

## initilization of mountainRange
puts "initilization of mountainRange"

RANGES.each do |range|
  MountainRange.create!(
    name: range[0],
    coord_lat: range[2],
    coord_long: range[3]
    )
end

######
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

## SEED BASECAMPS
puts "Seeding basecamps..."
NB_INHAB = 20_000 # Change this param if needed
SCOPE_DEPARTMENTS = %w[74 38 73 04 05 06].freeze # Change this param if needed
MAX_DIST_FROM_MOUNTAIN_RANGE = 80 # max distance (km) between a mountain_range and a basecamp

cities = csv_to_cities('db/csv_repos/french_cities.csv')
cities = filter_on_cities(cities, NB_INHAB, SCOPE_DEPARTMENTS)
feed_basecamps(cities, MAX_DIST_FROM_MOUNTAIN_RANGE)

puts "Basecamps seeding completed"
