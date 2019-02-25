require 'csv'

## BASECAMPS SEEDING

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

def feed_basecamps(cities)
  cities.each do |city|
    Basecamp.create!(name: city[:name],
                     coord_long: city[:coord_long],
                     coord_lat: city[:coord_lat])
  end
end

cities = csv_to_cities('db/csv_repos/french_cities.csv')
cities = filter_on_cities(cities, 20_000, %w[74 38 73 04 05 06])

feed_basecamps(cities)
