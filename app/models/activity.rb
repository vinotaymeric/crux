class Activity < ApplicationRecord
  has_many :users
  has_many :basecamps_activities
  has_many :itineraries, dependent: :destroy
end
