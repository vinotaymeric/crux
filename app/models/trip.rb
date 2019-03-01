class Trip < ApplicationRecord
  belongs_to :user
  has_many :trips_basecamps_activities
  has_many :basecamps_activities, through: :trips_basecamps_activities
  validates :start_date, presence: true
  validates :end_date, presence: true
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long
end
