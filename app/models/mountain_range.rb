class MountainRange < ApplicationRecord
  has_many :basecamps
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
