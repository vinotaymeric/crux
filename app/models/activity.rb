class Activity < ApplicationRecord
  has_many :users
  has_many :basecamps_activities
  has_many :itineraries, dependent: :destroy

  # tout est às dynamiser
  def placeholder_image
    cloudinary_url = "https://res.cloudinary.com/dbehokgcg/image/upload/v1552908931"
    if self.name == "skitouring"
      "#{cloudinary_url}/ski.png"
    elsif self.name == "mountain_climbing"
    "#{cloudinary_url}/alpi.png"
    elsif self.name == "rock_climbing"
      "#{cloudinary_url}/escalade.png"
    else
      "#{cloudinary_url}/hike.jpg"
    end
  end

  NAMES = [
          ["snowshoeing", "raquette"], ["skitouring", "ski de rando"], ["hiking", "randonnée"],
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
