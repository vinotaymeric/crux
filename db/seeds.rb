require_relative 'bra_functions'
require_relative 'lib/basecamp_seeding'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'date'
require 'pry'
require "base64"


## BASECAMPS SEEDING
NB_INHAB = 20_000 # Change this param if needed
SCOPE_DEPARTMENTS = %w[74 38 73 04 05 06].freeze # Change this param if needed

cities = csv_to_cities('db/csv_repos/french_cities.csv')
cities = filter_on_cities(cities, NB_INHAB, SCOPE_DEPARTMENTS)

p feed_basecamps(cities)


# puts "Seeding Activities..."


if Activity.count == 0
  Activity.create!(name: "ski de randonnée")
  Activity.create!(name: "alpinisme")
  Activity.create!(name: "escalade")
  Activity.create!(name: "cascade de glace")
end

# SEED ITINERARIES FROM CAMP_TO_CAMP


puts "Seeding Itineraries..."

def api_call(itinerary, id)
  url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
  p url
  JSON.parse(open(url).read)
end

def convert_epsg_3857_to_4326(web_mercator_x, web_mercator_y)
  url = "https://epsg.io/trans?x=#{web_mercator_x}&y=#{web_mercator_y}&s_srs=3857&t_srs=4326"
  response = JSON.parse(open(url).read)
  { long: response["x"], lat: response["y"] }
end

# Itinerary.destroy_all

sitemap0 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/0.xml"))
sitemap1 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/1.xml"))
itinerary_ids = []

sitemap0.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

sitemap1.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

itinerary_ids.map! { |id| id.to_i }
itinerary_ids.select! { |id| id > 49833 }


itinerary_ids.map! { |id| id.to_i }
itinerary_ids.select! { |id| id > 53958 }


#   #CHECK DISTANCE FROM THE ALPS
#   #Feed epsg 3857 coords
#   itinerary.coord_x = itinerary_hash["geometry"]["geom"][17..-1].split(",")[0]
#   itinerary.coord_y = itinerary_hash["geometry"]["geom"][17..-1].split(",")[1][1..-2]


itinerary_ids.each do |id|


#   #If too far from chambery (500km), go to next iti
#   next if itinerary.distance_from([45.564601, 5.917781]) > 500

#   # Exclude activites we don't care about. Define activites in French, only taking the main activity
#   activities = ["skitouring", "snow_ice_mixed", "mountain_climbing", "rock_climbing", "ice_climbing"]
#   next if activities.exclude?(itinerary_hash["activities"][0])
  begin



  itinerary_hash = api_call("routes", id)
  itinerary = Itinerary.new

  #CHECK DISTANCE FROM THE ALPS
  #Feed epsg 3857 coords
  itinerary.coord_x = itinerary_hash["geometry"]["geom"][17..-1].split(",")[0]
  itinerary.coord_y = itinerary_hash["geometry"]["geom"][17..-1].split(",")[1][1..-2]

  #Add gps coords
  gps_coords = convert_epsg_3857_to_4326(itinerary.coord_x, itinerary.coord_y)
  itinerary.coord_long = gps_coords[:long]
  itinerary.coord_lat = gps_coords[:lat]

  #If too far from chambery (500km), go to next iti
  next if itinerary.distance_from([45.564601, 5.917781]) > 500

  # Exclude activites we don't care about. Define activites in French, only taking the main activity
  activities = ["skitouring", "snow_ice_mixed", "mountain_climbing", "rock_climbing", "ice_climbing"]
  next if activities.exclude?(itinerary_hash["activities"][0])

  activity = itinerary_hash["activities"][0]



#   # Other details about the itinerary
#   itinerary.elevation_max = itinerary_hash["elevation_max"]
#   itinerary.height_diff_up = itinerary_hash["height_diff_up"]
#   itinerary.engagement_rating = itinerary_hash["engagement_rating"]
#   itinerary.equipment_rating = itinerary_hash["equipment_rating"]
#   itinerary.orientations = itinerary_hash["orientations"]

  if activity == "skitouring"
    itinerary.activity = Activity.find_by(name: "ski de randonnée")
  elsif activity == "snow_ice_mixed" || activity == "mountain_climbing"
    itinerary.activity = Activity.find_by(name: "alpinisme")
  elsif activity == "rock_climbing"
    itinerary.activity = Activity.find_by(name: "escalade")
  elsif activity == "ice_climbing"
    itinerary.activity = Activity.find_by(name: "casacade de glace")
  end




  # Other details about the itinerary
  itinerary.elevation_max = itinerary_hash["elevation_max"]
  itinerary.height_diff_up = itinerary_hash["height_diff_up"]
  itinerary.engagement_rating = itinerary_hash["engagement_rating"]
  itinerary.equipment_rating = itinerary_hash["equipment_rating"]
  itinerary.orientations = itinerary_hash["orientations"]


  itinerary_hash["locales"].each do |locale|
    if locale["lang"] == "fr" && locale["title"] != nil
      itinerary.name = "#{locale["title_prefix"]} #{locale["title"]}"
      itinerary.content = locale["description"]
    elsif locale["lang"] == "fr" && locale["title"].nil?
      itinerary.name = locale["title"]
    end
  end

  itinerary.number_of_outing = api_call("outings", id)["associations"]["recent_outings"]["total"]
  itinerary.save!
  print "."
  break if Itinerary.count > 9000
  sleep(2)
end


  itinerary.number_of_outing = api_call("outings", id)["associations"]["recent_outings"]["total"]
  itinerary.save!
  print "."
  break if Itinerary.count > 9000
  sleep(1)
  rescue Exception => e
  puts "#{id} a pété"
  puts e.message
  end
end


# puts "Itineraries seeding completed"




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
## initilization of mountainRange
puts "initilization of mountainRange"

NAME;CTC_ID;COORD_LAT;COORD_LONG
# MountainRange.destroy_all

date = 20190220

##bra de tous les ranges
bra_ranges = bra_all_ranges_per_date(date)

p "nbr de bra #{bra_ranges.length}, date  #{date}}"

bra_ranges.each do |bra_range|
  if MountainRange.count == 0
  MountainRange.create!(
    name:bra_range[:range_name],
    rosace_url: bra_range[:rosace_image_url],
    fresh_snow_url: bra_range[:fresh_snow_image_url],
    snow_image_url: bra_range[:snow_image_url],
    snow_quality: bra_range[:snow_quality],
    stability: bra_range[:stability]
    )

  else
    # MountainRange.(
    #   name:bra_range[:range_name], 
    #   rosace_url: bra_range[:rosace_image_url], 
    #   fresh_snow_url: bra_range[:fresh_snow_image_url],
    #   snow_image_url: bra_range[:snow_image_url],
    #   snow_quality: bra_range[:snow_quality],
    #   stability: bra_range[:stability]
    #   )
    p "#{bra_range[:range_name]} not created!"
  end


end

##bra par range
# bra_mont_blanc = bra_per_range_per_date("MONT-BLANC",date)
## create MountainRange MONT-BLANC
# MountainRange.create!(
#   name:bra_mont_blanc[:range_name],
#   rosace_url: bra_mont_blanc[:rosace_image_url],
#   fresh_snow_url: bra_mont_blanc[:fresh_snow_image_url],
#   snow_image_url: bra_mont_blanc[:snow_image_url],
#   snow_quality: bra_mont_blanc[:snow_quality],
#   stability: bra_mont_blanc[:stability]
#   )

puts "####MountainRange seeding completed###"
