def api_call(itinerary, id)
  url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
  JSON.parse(open(url).read)
end

def convert_epsg_3857_to_4326(web_mercator_x, web_mercator_y)
  url = "https://epsg.io/trans?x=#{web_mercator_x}&y=#{web_mercator_y}&s_srs=3857&t_srs=4326"
  response = JSON.parse(open(url).read)
  { long: response["x"], lat: response["y"] }
end

def api_route(ori, desti)
  ori_lat = ori.coord_lat
  ori_long = ori.coord_long
  desti_lat = desti.coord_lat
  desti_long = desti.coord_long
  url = "https://api.openrouteservice.org/matrix?api_key=#{ENV['ORS_API_KEY']}&profile=driving-car&locations=#{ori_long},#{ori_lat}%7C#{desti_long},#{desti_lat}"
  duration = JSON.parse(open(url).read)["durations"][0][1]
end

def point_included_in_polygon?(polygon_array, point)
  last_point = polygon_array[-1]
  oddNodes = false
  x = point.lng
  y = point.lat

  polygon_array.each do |p|
    yi = p[1]
    xi = p[0]
    yj = last_point[1]
    xj = last_point[0]
    if yi < y && yj >= y ||
        yj < y && yi >= y
      oddNodes = !oddNodes if xi + (y - yi) / (yj - yi) * (xj - xi) < x
    end

    last_point = p
  end
  return oddNodes
end

def define_centroid(area)
  coord_long = 0
  coord_lat = 0
  basecamps = area.basecamps
  basecamps.each do |basecamp|
    coord_long += basecamp.coord_long
    coord_lat += basecamp.coord_lat
  end
  area.coord_long = coord_long / basecamps.count
  area.coord_lat = coord_lat / basecamps.count
end

def weather_api_call(lat, lon)
  url = "https://api.apixu.com/v1/forecast.json?key=3a0aef724b764f6cb35161705192702&q=#{lat},#{lon}&days=7"
  JSON.parse(open(url).read)
end

def define_city(isochrone, area)
  near_cities = City.near([area.coord_lat, area.coord_long], 20, units: :km)
  nearest_cities = []

  near_cities.each do |city|
    city_point = Geokit::LatLng.new(city.coord_lat, city.coord_long)
    nearest_cities << city if point_included_in_polygon?(isochrone, city_point)
    # p city.name if point_included_in_polygon?(isochrone, city_point)
  end

  best_city = nearest_cities.sort_by { |city| city.city_inhab.to_i }.reverse[0]
  # p "toto" if best_city.nil?
  best_city = City.near([area.coord_lat, area.coord_long], 50, units: :km)[0] if best_city.nil?
  area.update!(city: best_city)
  p "Area has for city: #{area.city.name}"
end
