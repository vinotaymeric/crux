class Trip < ApplicationRecord
  belongs_to :user
  has_many :basecamps, through: :trips_basecamps
  # validates :start_date, presence: true
  # validates :end_date, presence: true
end
