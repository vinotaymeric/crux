class Weather < ApplicationRecord
  has_many :cities
  has_many :itineraries, through: :areas
end
