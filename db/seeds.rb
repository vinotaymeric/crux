require_relative 'bra_functions'
require_relative 'lib/basecamp'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'date'
require 'pry'
require "base64"


## SEED RANGES
# MountainRange.destroy_all
# puts "###Seeding MountainRange#### "
# ## initilization of mountainRange
# puts "initilization of mountainRange"

# RANGES.each do |range|
#   MountainRange.create!(
#     name: range[0],
#     coord_lat: range[2],
#     coord_long: range[3]
#     )
# end
# puts "initilization of mountainRange completed"

## update mountainRnages
date = 20190225
###
ap "update mountain_ranges at Date : #{date}"
update_mountain_ranges(date)
puts "####MountainRange seeding completed###"


