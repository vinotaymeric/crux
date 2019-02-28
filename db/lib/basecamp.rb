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

def filter_on_cities(cities, min_inhab = 0, departments = [])
  cities.select! { |city| city[:inhab] > min_inhab }
  unless departments.empty?
    cities.select! { |city| departments.include? city[:dep] }
  end
  cities
end

def set_mountain_range(basecamp, max_dist)
  mountain_ranges = MountainRange.all
  mountain_ranges.each do |mountain_range|
    if basecamp.mountain_range.nil?
      basecamp.mountain_range = mountain_range unless basecamp.distance_from(mountain_range) > max_dist
    elsif basecamp.distance_from(mountain_range) < basecamp.distance_from(basecamp.mountain_range)
      basecamp.mountain_range = mountain_range
    end
  end
end

def feed_basecamps(cities, max_dist_from_mountain_range)
  cities.each do |city|
    new_basecamp = Basecamp.new(
      name: city[:name],
      coord_long: city[:coord_long],
      coord_lat: city[:coord_lat],
      city_inhab: city[:inhab]
    )
    set_mountain_range(new_basecamp, max_dist_from_mountain_range)
    new_basecamp.save!
  end
end
