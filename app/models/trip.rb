class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :itinerary
  has_many :basecamp
  validates :start_date, presence: true
  validates :end_date, presence: true
end
