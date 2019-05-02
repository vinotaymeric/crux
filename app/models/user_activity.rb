class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  def itineraries
    return if level.nil?
    Itinerary.where(activity: activity, universal_difficulty: level.downcase)
  end

  def set?
    !level.nil?
  end
end

