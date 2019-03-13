require 'json'
require 'open-uri'
require 'nokogiri'

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

sitemap0 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/0.xml"))
sitemap1 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/1.xml"))
itinerary_ids = []

sitemap0 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/0.xml"))
sitemap1 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/1.xml"))
itinerary_ids = []

sitemap0.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

sitemap1.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

itinerary_ids.each do |id|

  begin

  itinerary_hash = api_call("routes", id)
  itinerary = Itinerary.new

  itinerary.source_id = id

  #CHECK DISTANCE FROM THE ALPS
  #Feed epsg 3857 coords
  itinerary.coord_x = itinerary_hash["geometry"]["geom"][17..-1].split(",")[0]
  itinerary.coord_y = itinerary_hash["geometry"]["geom"][17..-1].split(",")[1][1..-2]

  #Add gps coords
  gps_coords = convert_epsg_3857_to_4326(itinerary.coord_x, itinerary.coord_y)
  itinerary.coord_long = gps_coords[:long]
  itinerary.coord_lat = gps_coords[:lat]

  # Find the main activity of the itinerary, create if if it does not exist
  activity = itinerary_hash["activities"][0]

  if Activity.find_by(name: activity).nil?
    itinerary.activity = Activity.create!(name: activity)
  else
    itinerary.activity = Activity.find_by(name: activity)
  end

  # Other details about the itinerary
  itinerary.elevation_max = itinerary_hash["elevation_max"] if itinerary_hash["elevation_max"] != nil
  itinerary.height_diff_up = itinerary_hash["height_diff_up"] if itinerary_hash["height_diff_up"] != nil
  itinerary.engagement_rating = itinerary_hash["engagement_rating"] if itinerary_hash["engagement_rating"] != nil
  itinerary.equipment_rating = itinerary_hash["equipment_rating"] if itinerary_hash["equipment_rating"] != nil
  itinerary.orientations = itinerary_hash["orientations"] if itinerary_hash["orientations"] != nil

  itinerary.number_of_outing = api_call("outings", id)["associations"]["recent_outings"]["total"]

  # Iti name
  itinerary_hash["locales"].each do |locale|
    if locale["lang"] == "fr" && locale["title"] != nil
      itinerary.name = "#{locale["title_prefix"]} #{locale["title"]}"
      itinerary.content = locale["description"]
    elsif locale["lang"] == "fr" && locale["title"].nil?
      itinerary.name = locale["title"]
    end
  end

  # Waypoints and basecamps
  itinerary_hash["associations"]["waypoints"].each do |waypoint|
    if waypoint["waypoint_type"] == "access"
      source_id = waypoint["document_id"]
      if Basecamp.find_by(source_id: source_id).nil?

        basecamp = Basecamp.new(source_id: source_id)

        #Add gps coords
        coord_x = waypoint["geometry"]["geom"][17..-1].split(",")[0]
        coord_y = waypoint["geometry"]["geom"][17..-1].split(",")[1][1..-2]
        gps_coords = convert_epsg_3857_to_4326(coord_x, coord_y)
        basecamp.coord_long = gps_coords[:long]
        basecamp.coord_lat = gps_coords[:lat]

        #Add name
        waypoint["locales"].each do |locale|
          if locale["lang"] == "fr" && locale["title"] != nil
            basecamp.name = "#{locale["title_prefix"]} #{locale["title"]}"
          elsif locale["lang"] == "fr" && locale["title"].nil?
            basecamp.name = locale["title"]
          end
        end

        basecamp.save!
      else
        itinerary.basecamp = Basecamp.find_by(source_id: source_id)
      end
    return
    end
  end

  itinerary.save!
  print "."
  break if Itinerary.count > 10
  sleep(0.5)
  rescue Exception => e
  puts "#{id} a pété"
  puts e.message
  end
end
