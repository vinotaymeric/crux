class MountainRange < ApplicationRecord
  has_many :basecamps, dependent: :nullify
  has_many :cities
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
