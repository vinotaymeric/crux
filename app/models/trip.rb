class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :city, optional: true
  belongs_to :user_activity, optional: true
  has_many :favorite_itineraries
  has_many :itineraries, through: :favorite_itineraries
  has_many :trip_activities
  has_one :trip_activity
  attribute :validated, default: false
  validates :start_date, presence: true
  validates :end_date, presence: true
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long
  after_validation :geocode, if: :will_save_change_to_location?

  def duration
    self.start_date.upto(self.end_date).to_a.size
  end

  def short_address
    self.location.split(" ")[0].gsub(",", "")
  end

end
