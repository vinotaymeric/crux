class BasecampsActivity < ApplicationRecord
  # belongs_to :activity
  belongs_to :activity
  belongs_to :basecamp
  has_one :weather, :through => :basecamp
  has_many :basecamps_activities_itineraries
  has_many :itineraries, through: :basecamps_activities_itineraries
  has_many :trips_basecamps_activities
  has_many :trips, through: :trips_basecamps_activities
end
