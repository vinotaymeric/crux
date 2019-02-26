class Itinerary < ApplicationRecord
  has_one :activity
  has_many :basecamps_itineraries
  has_many :basecamp, throught: :basecamps_itineraries
end
