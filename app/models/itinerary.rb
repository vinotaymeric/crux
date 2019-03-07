require "objspace"

class Itinerary < ApplicationRecord

  include AlgoliaSearch
  algoliasearch if: :small? do
  end

  belongs_to :activity
  has_many :favorite_itineraries
  has_many :trips, through: :favorite_itinerary
  has_many :basecamps_activities_itineraries
  has_many :basecamps_activities, through: :basecamps_activities_itineraries
  geocoded_by :address, latitude: :coord_lat, longitude: :coord_long
  self.per_page = 3

  def small?
    ObjectSpace.memsize_of(content.to_json) < 10000
  end
  #WillPaginate.per_page = 10
end
