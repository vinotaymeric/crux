class Area < ApplicationRecord
  has_many :basecamps, dependent: :nullify
  has_many :itineraries, through: :basecamps
  belongs_to :city, optional: true
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long
end
