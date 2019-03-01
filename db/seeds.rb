puts "###Seeding MountainRange#### "


MountainRange.delete_all

puts "initilization of mountainRange"

RANGES.each do |range|
  MountainRange.create!(
    name: range[0],
    coord_lat: range[2],
    coord_long: range[3]
    )
end

######
date = 20190220

update_mountain_ranges(date)

puts "####MountainRange seeding completed###"

## SEED BASECAMPS
puts "Seeding basecamps..."
NB_INHAB = 20_000 # Change this param if needed
SCOPE_DEPARTMENTS = %w[74 38 73 04 05 06].freeze # Change this param if needed
MAX_DIST_FROM_MOUNTAIN_RANGE = 80 # max distance (km) between a mountain_range and a basecamp

cities = csv_to_cities('db/csv_repos/french_cities.csv')
cities = filter_on_cities(cities, NB_INHAB, SCOPE_DEPARTMENTS)
feed_basecamps(cities, MAX_DIST_FROM_MOUNTAIN_RANGE)

puts "Basecamps seeding completed"

## SEED BASECAMPS_ACTIVITIES
Basecamp.all.each do |basecamp|
  Activity.all.each do |activity|
    BasecampsActivity.create!(basecamp: basecamp, activity: activity)
  end
end

## SEED BASECAMPS_ACTIVITIES_ITINERARIES

BasecampsActivity.all.each do |basecamps_activity|
  Itinerary.all[0..10].each do |itinerary|
    BasecampsActivitiesItinerary.create!(basecamps_activity: basecamps_activity, itinerary: itinerary)
  end
end

