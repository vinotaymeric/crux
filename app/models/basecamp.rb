class Basecamp < ApplicationRecord
  has_many :trips_basecamps
  belongs_to :activity
  has_many :trips, through: :trips_basecamps
  has_many :itineraries, through: :basecamps_itineraries
end
