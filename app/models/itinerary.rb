class Itinerary < ApplicationRecord
  belongs_to :activity
  has_many :basecamps_itineraries
  has_many :basecamp, through: :basecamps_itineraries
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
