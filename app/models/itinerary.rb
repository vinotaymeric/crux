class Itinerary < ApplicationRecord
  belongs_to :activity
  has_many :basecamps_itineraries
  has_many :basecamp, throught: :basecamps_itineraries
end
