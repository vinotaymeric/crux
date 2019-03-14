require 'json'
require 'open-uri'
require 'nokogiri'
require_relative 'lib/seed_functions'
require_relative 'lib/bra_functions'
require_relative 'lib/basecamp'
require 'date'
require 'pry'
require "base64"

# # puts "Delete all..."

# date = 20190312
# ##bra de tous les ranges
# bra_ranges = bra_all_ranges_per_date(date)

# p "nbr de bra #{bra_ranges.length}, date  #{date}}"

# bra_ranges.each do |bra_range|

#   next if MountainRange.find_by(name: bra_range[:range_name]).nil?
#   p "done"
#   MountainRange.find_by(name: bra_range[:range_name]).update!(
#     name: bra_range[:range_name],
#     bra_date: bra_range[:bra_date_validity],
#     rosace_url: bra_range[:rosace_image_url],
#     fresh_snow_url: bra_range[:fresh_snow_image_url],
#     snow_image_url: bra_range[:snow_image_url],
#     snow_quality: bra_range[:snow_quality],
#     stability: bra_range[:stability]
#     )
# end


puts "Seeding Itineraries..."

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

itinerary_ids.uniq!
reached_id = Itinerary.maximum('source_id')

p itinerary_ids.count
p itinerary_ids.last
p reached_id

itinerary_ids.each do |id|
  next if id.to_i <= reached_id

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
  itinerary.height_diff_down = itinerary_hash["height_diff_down"] if itinerary_hash["height_diff_down"] != nil
  itinerary.engagement_rating = itinerary_hash["engagement_rating"] if itinerary_hash["engagement_rating"] != nil
  itinerary.equipment_rating = itinerary_hash["equipment_rating"] if itinerary_hash["equipment_rating"] != nil
  itinerary.orientations = itinerary_hash["orientations"] if itinerary_hash["orientations"] != nil
  itinerary.ski_rating = itinerary_hash["ski_rating"] if itinerary_hash["ski_rating"] != nil
  itinerary.hiking_rating = itinerary_hash["hiking_rating"] if itinerary_hash["hiking_rating"] != nil

  if itinerary_hash["associations"]["images"][0] != nil
    itinerary.picture_url = "https://media.camptocamp.org/c2corg-active/#{itinerary_hash["associations"]["images"][0]["filename"]}"
  end

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

  # Waypoints
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
        itinerary.basecamp = basecamp
        p basecamp
      else
        itinerary.basecamp = Basecamp.find_by(source_id: source_id)
      end
    end
  end

  # Hut
  itinerary_hash["associations"]["waypoints"].each do |waypoint|
    if waypoint["waypoint_type"] == "hut"
      source_id = waypoint["document_id"]
      if Hut.find_by(source_id: source_id).nil?

        hut = Hut.new(source_id: source_id)

        #Add gps coords
        coord_x = waypoint["geometry"]["geom"][17..-1].split(",")[0]
        coord_y = waypoint["geometry"]["geom"][17..-1].split(",")[1][1..-2]
        gps_coords = convert_epsg_3857_to_4326(coord_x, coord_y)
        hut.coord_long = gps_coords[:long]
        hut.coord_lat = gps_coords[:lat]

        #Add name
        waypoint["locales"].each do |locale|
          if locale["lang"] == "fr" && locale["title"] != nil
            hut.name = "#{locale["title_prefix"]} #{locale["title"]}"
          elsif locale["lang"] == "fr" && locale["title"].nil?
            hut.name = locale["title"]
          end
        end
        hut.save!
        itinerary.hut = hut
        p hut
      else
        itinerary.hut = Hut.find_by(source_id: source_id)
      end
    end
  end

  itinerary.save!

  # Outings
  if itinerary.number_of_outing > 0
    itinerary_hash["associations"]["recent_outings"]["documents"].each do |outing|
      Outing.create!(itinerary: itinerary, date: outing["date_start"])
    end
  end

  p id
  print "."
  sleep(0.2)
  rescue Exception => e
  puts "#{id} a pété"
  puts e.message
  end

end

# Once itineries seed is completed

# basecamps = Basecamp.all

# puts "seeding areas..."

# basecamps.each do |basecamp|
#   next if basecamp.area != nil
#   sleep(1.5)
#   p "basecamp_id: #{basecamp.id}"

#   begin
#   new_area = Area.create!()
#   basecamp.update!(area: new_area)
#   isochrone = basecamp.isochrone_coordinates(900)
#   basecamps.each do |b2|
#     begin
#     next if b2.area != nil
#     next if basecamp.distance_from(b2) > 20
#       b2_point = Geokit::LatLng.new(b2.coord_lat, b2.coord_long)
#       if point_included_in_polygon?(isochrone, b2_point)
#         b2.update!(area: new_area)
#       end
#     rescue Exception => e
#     puts e.message
#     end
#   end
#   p "basecamps in this area: #{new_area.basecamps.count}"
#   define_centroid(new_area)
#   define_city(isochrone, new_area)
#   new_area.save!
#   rescue Exception => e
#   puts e.message
#   end
# end

# # Generate weather

# Area.all.each do |area|
#   next if area.weather != nil
#   weather = Weather.new()
#   area.update!(weather: weather)
# end

# # Populate Weather with data, then will be done trough scheduler

# Weather.all.each do |weather|
#   begin
#   next if weather.forecast != nil
#   area = weather.area
#   weather_hash = api_call(area.coord_lat, area.coord_long)
#   weather.forecast = weather_hash["forecast"]["forecastday"]
#   weather.save!
#   p weather.id
#   rescue Exception => e
#   puts e.message
#   end
# end

