class Itinerary < ApplicationRecord
  belongs_to :activity
  has_many :trips
  has_many :basecamp
end
