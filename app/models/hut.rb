class Hut < ApplicationRecord
  # has_many :itineraries
  validates :name, presence: true
end
