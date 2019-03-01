require_relative 'bra_functions'
require_relative 'lib/basecamp'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'date'
require 'pry'
require "base64"

## Merge basecamps with mountain ranges
MAX_DIST_FROM_MOUNTAIN_RANGE = 80 # max distance (km) between a mountain_range and a basecamp

Basecamp.all.each do |basecamp|
  set_mountain_range(basecamp, MAX_DIST_FROM_MOUNTAIN_RANGE).save!
end

