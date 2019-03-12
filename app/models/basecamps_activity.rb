class BasecampsActivity < ApplicationRecord
  # belongs_to :activity
  belongs_to :activity
  belongs_to :basecamp
  has_many :trips
  has_one :weather, :through => :basecamp
  has_many :basecamps_activities_itineraries
  has_many :itineraries, through: :basecamps_activities_itineraries
end
