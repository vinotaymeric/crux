class Activity < ApplicationRecord
  has_many :users
  has_many :basecamps
  has_many :itineraries
end
