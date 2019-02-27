class Basecamp < ApplicationRecord
  has_many :trips_basecamps
  has_one :activity
  has_many :trips, through: :trips_basecamps
  has_many :itineraries, through: :basecamps_itineraries
  belongs_to :moutain_range
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
