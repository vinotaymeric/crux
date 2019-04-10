require "open-uri"
require "nokogiri"

class Basecamp < ApplicationRecord
  has_many :itineraries
  belongs_to :area, optional: true
  belongs_to :weather, optional: true
  belongs_to :mountain_range, optional: true
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
  acts_as_mappable :lat_column_name => :coord_lat,
                   :lng_column_name => :coord_long
end

