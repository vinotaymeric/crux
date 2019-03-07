class Itinerary < ApplicationRecord

  # include AlgoliaSearch
  # algoliasearch do
  #   begin
  #   rescue Exception => e
  #     puts "erreur"
  #   end
  # end

  belongs_to :activity
  has_many :favorite_itineraries
  has_many :trips, through: :favorite_itinerary
  has_many :basecamps_activities_itineraries
  has_many :basecamps_activities, through: :basecamps_activities_itineraries
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
  self.per_page = 3
  #WillPaginate.per_page = 10
end
