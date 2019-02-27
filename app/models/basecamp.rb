class Basecamp < ApplicationRecord
  has_many :trips_basecamps
  has_one :activity
  belongs_to :weather
  has_many :trips, through: :trips_basecamps
  has_many :itineraries, through: :basecamps_itineraries
end
