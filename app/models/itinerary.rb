class Itinerary < ApplicationRecord
  belongs_to :activity
  has_many :favorite_itineraries
  has_many :trips, through: :favorite_itinerary
  has_many :basecamps_activities_itineraries
  has_many :basecamps_activities, through: :basecamps_activities_itineraries
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
end
