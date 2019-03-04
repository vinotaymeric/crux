class Itinerary < ApplicationRecord
  self.per_page = 10
  belongs_to :activity
  has_many :basecamps_activities_itineraries
  has_many :basecamps_activities, through: :basecamps_activities_itineraries
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
