class Basecamp < ApplicationRecord
  has_many :basecamps_activities
  belongs_to :weather, optional: true
  # has_many :trips, through: :trips_basecamps
  # has_many :itineraries, through: :basecamps_itineraries
  belongs_to :mountain_range
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
