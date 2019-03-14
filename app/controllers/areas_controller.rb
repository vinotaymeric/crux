class AreasController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :init_mark_down_parser, only: :show

  def index
    @user = current_user
    @trip = Trip.find(params[:trip_id])

    areas_activities = []
    current_user.user_activities.each do |user_activity|

      p "skip" if user_activity.level == "Pas intéressé" || user_activity.level.nil?
      next if user_activity.level == "Pas intéressé" || user_activity.level.nil?

      activity = user_activity.activity
      p activity
      area_activity = Area.select("areas.*, COUNT(DISTINCT itineraries.id) as nb_itineraries")
      .joins(:itineraries)
      .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
      .where(user_activities: {user_id: current_user.id})
      .where(itineraries: {activity_id: activity.id})
      .group("areas.id")
      .order("nb_itineraries DESC")

    area_activity.each { |area| area.temp_activity = activity.name}
    areas_activities << area_activity
    end

    @one_hour_polygon = @trip.isochrone_coordinates

    areas_activities.flatten!
    # Remove area not linked to a city, mostly out of France
    areas_activities.select! { |area_activity| area_activity.city != nil }

    areas_activities.sort_by! do |area_activity|
      area_activity.temp_score = score(area_activity, @trip)
      [area_activity.temp_score, - @trip.distance_from(area_activity)]
    end

    # areas = Area.select("areas.*, COUNT(DISTINCT itineraries.id) as nb_itineraries")
    #   .joins(:itineraries)
    #   .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
    #   .where(user_activities: {user_id: current_user.id})
    #   .group("areas.id")
    #   .order("nb_itineraries DESC")
    #   .to_a
      # .where("user_activities.level = #{itineraries.universal_difficulty}") ==> handle at last

    # Define the isochrone around

    # Compute current score
    # areas.each do |area|
    #   area.current_score = score(area, @trip)
    # end

    # # Sort by score, then distance in case of equality
    # areas.sort_by! { |area| [area.current_score, - @trip.distance_from(area)]}

    # Take only top 18 and send them to the view
    @areas = areas_activities.reverse[0..17]

    # Mapbox
    @markers = @areas.map do |area|
      {
        lng: area.coord_long,
        lat: area.coord_lat,
        # infoWindow: render_to_string(partial: "infowindow", locals: { base: area, trip: @trip }),
        image_url: helpers.asset_url('https://cdn4.iconfinder.com/data/icons/eldorado-building/40/hovel_1-512.png')
      }
    end
    # Add trip start location
    @markers << {
        lng: @trip.coord_long,
        lat: @trip.coord_lat,
        image_url: helpers.asset_url('https://cdn1.iconfinder.com/data/icons/business-sets/512/target-512.png'),
    }
  end

  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def weather_day_score(forecast)
    if forecast["day"]["maxwind_kph"] < 50 && forecast["day"]["totalprecip_mm"] < 1 && forecast["day"]["avgvis_km"] > 5
      day_score = 1
    else
      day_score = -1
    end
    return day_score
  end

  def weather_trip_score(start_date, end_date, weather)
    weather_score = 0
    start_date.upto(end_date) do |date|
      weather.forecast.each do |forecast|
        weather_score += weather_day_score(forecast) if (Date.parse forecast["date"]) == date
      end
    end
    weather_score = [weather_score, 0.5].max
  end

  def score(area, trip)
    # Define all variables
    city = area.city
    bra = city.mountain_range
    weather = area.weather
    itinerary_count = area.itineraries.count

    # Comupute subscores
    bra.nil? || bra.max_risk.nil? ? avalanche_score = 0 : avalanche_score = bra.max_risk
    # Weather score
    weather_score = 0
    # weather_score = weather_trip_score(trip.start_date, trip.end_date, weather)
    # Distance score
    if area.included_in_polygon?(@one_hour_polygon)
      distance_score = 0
    else
      distance_score = trip.distance_from(area)
    end

    # Compute final score
    score = weather_score * [(itinerary_count / (2 * trip.duration)), 4].min - (distance_score / (5 * trip.duration)) - avalanche_score ** 2
  end
end
