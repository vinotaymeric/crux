class AreasController < ApplicationController
  before_action :init_mark_down_parser, only: :show

  def index
    @user = current_or_guest_user
    @trip = Trip.find(params[:trip_id])

    areas_activities = []
    current_or_guest_user.user_activities.each do |user_activity|

      next if user_activity.level == "Niveau ?" || user_activity.level.nil?

      activity = user_activity.activity

      area_activity = Area.select("areas.*, SUM(itineraries.score) as nb_good_itineraries, COUNT(itineraries.id) as nb_itineraries")
      .joins(:itineraries)
      .where(itineraries: {activity_id: activity.id, universal_difficulty: user_activity.level.downcase })
      .group("areas.id HAVING SUM(itineraries.score) > 0")

      area_activity.each { |area| area.temp_activity = activity.name}
      areas_activities << area_activity
    end


    @one_hour_polygon = @trip.isochrone_coordinates
    # double_polygon = @trip.double_polygon

    areas_activities.flatten!

    areas_activities.select! { |area_activity| area_activity.city != nil}

    areas_activities.sort_by! do |area_activity|
      area_activity.temp_score = score(area_activity, @trip)
      [area_activity.temp_score, - @trip.distance_from(area_activity)]
    end

    # Take only top 18 and send them to the view
    @areas = areas_activities.reverse[0..17]

    # Mapbox
    @markers = @areas.map do |area|
      {
        lng: area.coord_long,
        lat: area.coord_lat,
        infoWindow: render_to_string(partial: "infowindow", locals: {area: area}),
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
    if forecast["day"]["maxwind_kph"] < 50 && forecast["day"]["totalprecip_mm"] < 2 && forecast["day"]["avgvis_km"] > 5
      day_score = 1
    else
      day_score = -1
    end
    return day_score
  end

  def weather_trip_score(start_date, end_date, weather)
    weather_score = 0
    start_date.upto(end_date) do |date|
      next if weather.forecast.nil?
      weather.forecast.each do |forecast|
        weather_score += weather_day_score(forecast) if (Date.parse forecast["date"]) == date
      end
    end
    weather_score = [weather_score, 0.5].max
  end

  def score(area, trip)
    # Define all variables
    city = area.city
    # bra = city.mountain_range
    weather = area.weather
    itinerary_count = area.nb_good_itineraries

    # Comupute subscores
    # bra.nil? || bra.max_risk.nil? ? avalanche_score = 0 : avalanche_score = bra.max_risk
    # Weather score
    weather_score = weather_trip_score(trip.start_date, trip.end_date, weather)
    # Distance score
    if area.included_in_polygon?(@one_hour_polygon)
      distance_score = 1
    # elsif area.included_in_polygon?(double_polygon[1]) || area.included_in_polygon?(double_polygon[2]) || area.included_in_polygon?(double_polygon[3]) || area.included_in_polygon?(double_polygon[4])
    #   distance_score = 2
    else
      distance_score = 1 + trip.distance_from(area) / 50
    end

    # Compute final score
    score = ([weather_score, [(itinerary_count / 2), trip.duration].min].min) / distance_score ** (1.05 - trip.duration / 20)

    # p city.name
    # p "weather_score: #{weather_score}"
    # p "itinerary_count: #{itinerary_count}"
    # p "distance_score: #{distance_score}"
    # p "score: #{score}"

    # return score

  end
end
