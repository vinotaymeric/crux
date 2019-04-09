class Follow < ApplicationRecord
  belongs_to :itinerary
  belongs_to :user

  def self.itineraries
    follows = Follow.all
    itineraries = []
    follows.each do |follow|
      itineraries << follow.itinerary
    end
    itineraries
  end
end
