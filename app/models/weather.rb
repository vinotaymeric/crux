class Weather < ApplicationRecord
  has_many :areas
  has_many :itineraries, through: :areas
end
