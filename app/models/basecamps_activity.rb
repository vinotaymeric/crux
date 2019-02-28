class BasecampsActivity < ApplicationRecord
  # belongs_to :activity
  has_one :activity
  belongs_to :basecamp
  has_many :basecamps_activities_itineraries
  has_many :itinerary, through: :basecamps_activities_itineraries
  has_many :trips_basecamps_activities
  has_many :trips, through: :trips_basecamps_activities
end
