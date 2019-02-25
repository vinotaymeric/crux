class Basecamp < ApplicationRecord
  belongs_to :activity
  belongs_to :trip
  belongs_to :itinerary
  has_many :trips
  has_one :activity
  has_many :itineraries
end
