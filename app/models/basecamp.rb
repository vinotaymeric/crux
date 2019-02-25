class Basecamp < ApplicationRecord
  belongs_to :activity
  has_many :trips_basecamps
  has_many :itineraries, through: :basecamp_itineraries
end
