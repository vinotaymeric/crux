require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'


puts "Seeding Activities..."

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
  JSON.parse(open(url).read)
end

def convert_epsg_3857_to_4326(web_mercator_x, web_mercator_y)
  url = "https://epsg.io/trans?x=#{web_mercator_x}&y=#{web_mercator_y}&s_srs=3857&t_srs=4326"
  response = JSON.parse(open(url).read)
  { long: response["x"], lat: response["y"] }
end

Itinerary.destroy_all

sitemap0 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/0.xml"))
sitemap1 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/1.xml"))
itinerary_ids = []

sitemap0.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

sitemap1.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end


# Seeding itineraries

itinerary_ids.each do |id|
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

  if activity == "skitouring"
    itinerary.activity = Activity.find_by(name: "ski de randonnée")
  elsif activity == "snow_ice_mixed" || activity == "mountain_climbing"
    itinerary.activity = Activity.find_by(name: "alpinisme")
  elsif activity == "rock_climbing"
    itinerary.activity = Activity.find_by(name: "escalade")
  else
    itinerary.activity = Activity.find_by(name: "casacade de glace")
  end

  p itinerary.activity

  next if itinerary_hash["associations"]["images"][0] == nil
  itinerary.picture_url = "https://media.camptocamp.org/c2corg-active/#{itinerary_hash["associations"]["images"][0]["filename"]}"

  # Setting the difficulty, handling ski exception

  if itinerary_hash["ski_rating"].nil? && itinerary_hash["global_rating"].nil?
    itinerary.difficulty = nil
  elsif itinerary_hash["ski_rating"].nil?
    itinerary.difficulty = itinerary_hash["global_rating"]
  elsif itinerary_hash["ski_rating"].first == "2"
    itinerary.difficulty = "PD"
  elsif itinerary_hash["ski_rating"].first == "3"
    itinerary.difficulty = "AD"
  elsif itinerary_hash["ski_rating"].first == "4"
    itinerary.difficulty = "D"
  elsif itinerary_hash["ski_rating"].first == "5"
    itinerary.difficulty = "TD"
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

puts "Itineraries seeding completed"




## SEED FAKE USERS
puts "Seeding users..."

User.destroy_all

User.create!(email: "nico@crux.io", password: "qwertyuiop")
User.create!(email: "aymeric@crux.io", password: "azerty")
User.create!(email: "ouramadane@crux.io", password: "qwertyuiop")
User.create!(email: "jordi@crux.io", password: "qwertyuiop")

puts "User seeding completed"
