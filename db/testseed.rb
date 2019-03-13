require_relative 'bra_functions'
require_relative 'lib/basecamp'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'date'
require 'date'
require 'pry'
require "base64"

# Delete all

BasecampsActivitiesItinerary.delete_all
BasecampsActivity.delete_all
Basecamp.delete_all
MountainRange.delete_all
Weather.delete_all
FavoriteItinerary.delete_all
Trip.delete_all
Activity.delete_all

