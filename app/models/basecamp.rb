class Basecamp < ApplicationRecord
  belongs_to :activity
  belongs_to :trip
  belongs_to :itinerary
end
