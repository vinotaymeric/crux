require_relative 'lib/basecamp_seeding'

## BASECAMPS SEEDING
NB_INHAB = 20_000 # Change this param if needed
SCOPE_DEPARTMENTS = %w[74 38 73 04 05 06].freeze # Change this param if needed

cities = csv_to_cities('db/csv_repos/french_cities.csv')
cities = filter_on_cities(cities, NB_INHAB, SCOPE_DEPARTMENTS)

p feed_basecamps(cities)
