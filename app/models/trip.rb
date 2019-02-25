class Trip < ApplicationRecord
  belongs_to :user
  has_many :trips_basecamp
  validates :start_date, presence: true
  validates :end_date, presence: true
end
