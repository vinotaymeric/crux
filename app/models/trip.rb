require 'json'
require 'open-uri'

class Trip < ApplicationRecord
  belongs_to :user
  has_many :trips_basecamps_activities
  has_many :basecamps_activities, through: :trips_basecamps_activities
  has_many :favorite_itineraries
  has_many :itineraries, through: :favorite_itineraries
  attribute :validated, default: false
  validates :start_date, presence: true
  validates :end_date, presence: true
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long
  after_validation :geocode, if: :will_save_change_to_location?

  def duration
    self.start_date.upto(self.end_date).to_a.size
  end

  def one_hour_isochrone_coordinates
    url = "https://api.openrouteservice.org/isochrones?api_key=#{ENV['OPENROUTE_API_KEY']}&locations=#{self.coord_long},#{self.coord_lat}&profile=driving-car&range=3600"
    response = JSON.parse(open(url).read)["features"][0]["geometry"]["coordinates"][0]

    polygon = Geokit::Polygon.new([
      response.each do |coord|
        lat = coord[1]
        long = coord[0]
        Geokit::LatLng.new(lat, long)
      end
    ])
    return polygon.points[0]
  end

end
