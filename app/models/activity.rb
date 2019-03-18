class Activity < ApplicationRecord
  has_many :users
  has_many :basecamps_activities
  has_many :itineraries, dependent: :destroy

  # tout est às dynamiser
  def placeholder_image
    "crux/images/ski.png.png"
  end

  NAMES = [
          ["snowshoeing", "raquette"], ["skitouring", "ski"], ["hiking", "randonnée"],
          ["snow_ice_mixed", "mixte"], ["mountain_climbing", "alpinisme"], ["rock_climbing", "escalade"],
          ["ice_climbing", "cascade"], ["via_ferrata", "via ferrata"]
          ]

  def short_name
    english_index = NAMES.flatten.index(self.name)
    english_index.nil? ? self.name : NAMES.flatten[english_index + 1]
  end

  def self.expert_activities
    ids = []
    ids << Activity.find_by(name: "snowshoeing").id
    ids << Activity.find_by(name: "snow_ice_mixed").id
    ids << Activity.find_by(name: "ice_climbing").id
    ids << Activity.find_by(name: "via_ferrata").id
    ids << Activity.find_by(name: "mountain_biking").id
    ids << Activity.find_by(name: "slacklining").id
    ids
  end
end
