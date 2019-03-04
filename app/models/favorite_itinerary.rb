class FavoriteItinerary < ApplicationRecord
  belongs_to :trip
  belongs_to :itinerary
end
