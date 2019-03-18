class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def isochrone_coordinates(time_in_s = 3600)
    url = "https://api.openrouteservice.org/isochrones?api_key=#{ENV['OPENROUTE_API_KEY']}&locations=#{self.coord_long},#{self.coord_lat}&profile=driving-car&range=#{time_in_s}"
    response = JSON.parse(open(url).read)["features"][0]["geometry"]["coordinates"][0]

    polygon = Geokit::Polygon.new([
      response.each do |coord|
        lat = coord[1]
        long = coord[0]
        Geokit::LatLng.new(lat, long)
      end
    ])
    return polygon.points[0]
  end

  def double_polygon
    polygon = self.isochrone_coordinates
    points = []
    points << polygon[0]
    slice = (polygon.size / 4).round.to_i
    points << polygon[slice]
    points << polygon[slice * 2]
    points << polygon[slice * 3]
    polygons = [polygon]

    points.each do |point|
      url = "https://api.openrouteservice.org/isochrones?api_key=#{ENV['OPENROUTE_API_KEY']}&locations=#{point[1]},#{point[0]}&profile=driving-car&range=3600"
      p url
      response = JSON.parse(open(url).read)["features"][0]["geometry"]["coordinates"][0]
      polygon = Geokit::Polygon.new([
        response.each do |coord|
          lat = coord[1]
          long = coord[0]
          Geokit::LatLng.new(lat, long)
        end
      ])
      polygons << polygon
    end
    polygons
  end

  def included_in_polygon?(polygon_array)
    last_point = polygon_array[-1]
    oddNodes = false
    x = self.coord_long
    y = self.coord_lat

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
end
