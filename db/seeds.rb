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

