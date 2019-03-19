require 'csv'

def csv_to_cities(file_path)
  csv_options = { col_sep: ';', quote_char: '"',
                  headers: :first_row, encoding: 'ISO8859-1' }
  cities = []
  CSV.foreach(file_path, csv_options) do |row|
    cities << { name: row['libgeo'], code_insee: row['codgeo'],
                dep: row['dep'], reg: row['reg'], coord_lat: row['lat'].to_f,
                coord_long: row['long'].to_f, inhab: row['inhab_2019'].to_i }
  end
  cities
end

def csv_to_geoname_ids(file_path)
  csv_options = { col_sep: ';', quote_char: '"',
                  headers: :first_row }
  geoname_ids = []
  CSV.foreach(file_path, csv_options) do |row|
    geoname_ids << { geoname_id: row['geoname_id'], code_insee: row['code_insee'] }
  end
  geoname_ids
end

def filter_on_cities(cities, min_inhab = 0, departments = [])
  cities.select! { |city| city[:inhab] > min_inhab }
  unless departments.empty?
    cities.select! { |city| departments.include? city[:dep] }
  end
  cities
end

def set_mountain_range(city, max_dist)
  mountain_ranges = MountainRange.all
  mountain_ranges.each do |mountain_range|
    if city.mountain_range.nil?
      city.mountain_range = mountain_range unless city.distance_from(mountain_range) > max_dist
    elsif city.distance_from(mountain_range) < city.distance_from(city.mountain_range)
      city.mountain_range = mountain_range
    end
  end
  city
end

def feed_cities(cities, max_dist_from_mountain_range)
  cities.each do |city|
    new_city = City.new(
      name: city[:name],
      coord_long: city[:coord_long],
      coord_lat: city[:coord_lat],
      city_inhab: city[:inhab],
      code_insee: city[:code_insee]
    )
    set_mountain_range(new_city, max_dist_from_mountain_range)
    new_city.save!
  end
end
