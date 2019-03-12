class BasecampsActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :init_mark_down_parser, only: :show

  def index
    @user = current_user
    @trip = Trip.find(params[:trip_id])

    # See how many itineraries match the user profile and trip search
    basecamps_activities = BasecampsActivity.select("basecamps_activities.*, COUNT(basecamps_activities_itineraries.itinerary_id) as nb_itineraries").joins(:itineraries)
      .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
      .where(user_activities: {user_id: current_user.id})
      .where("user_activities.level = itineraries.level")
      .group("basecamps_activities.id")
      .order("COUNT(basecamps_activities_itineraries.itinerary_id) DESC")
      .to_a

    # Define the isochrone around
    @one_hour_polygon = @trip.one_hour_isochrone_coordinates

    # Compute score also considering weather and localisation
    basecamps_activities.sort_by! do |basecamp_activity|
      score(basecamp_activity, @trip)
    end

    # Take only top 18
    @basecamps_activities = basecamps_activities.reverse[0..17]

    # Mapbox
    @markers = @basecamps_activities.map do |base|
      {
        lng: base.basecamp.coord_long,
        lat: base.basecamp.coord_lat,
        infoWindow: render_to_string(partial: "infowindow", locals: { base: base, trip: @trip }),
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

  def show
    @basecamp_activity = BasecampsActivity.find(params[:id])
    @basecamp = @basecamp_activity.basecamp
    @activity = @basecamp_activity.activity
    @mountain_range = @basecamp.mountain_range
    user_level_for_activity = current_user.user_activities.find_by(activity_id: @activity.id).level
    @trip = Trip.find(params[:trip_id])

    if @trip.validated
      @itineraries = @trip.itineraries.distinct
    else
      @itineraries = @basecamp_activity.itineraries.where(level: user_level_for_activity )
    end

    @favorite_itinerary = FavoriteItinerary.new
  end

  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def weather_day_score(forecast)
    # if condition checks that there it'a s good day : no wind, rain and good vis.
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

  def point_included_in_polygon?(polygon_array, point)
    last_point = polygon_array[-1]
    oddNodes = false
    x = point.lng
    y = point.lat

    polygon_array.each do |p|
      yi = p[1]
      xi = p[0]
      yj = last_point[1]
      xj = last_point[0]
      if yi < y && yj >= y ||
          yj < y && yi >= y
        oddNodes = !oddNodes if xi + (y - yi) / (yj - yi) * (xj - xi) < x
      end

      last_point = p
    end
    return oddNodes
  end

  def score(basecamp_activity, trip)
    # Define all variables
    bra = basecamp_activity.basecamp.mountain_range
    basecamp = basecamp_activity.basecamp
    weather = basecamp.weather
    itinerary_count = basecamp_activity.itineraries.count

    # Comupute subscores
    bra.nil? ? avalanche_score = 0 : avalanche_score = bra.max_risk
    # Weather score
    weather_score = weather_trip_score(trip.start_date, trip.end_date, weather)
    # Distance score
    center = Geokit::LatLng.new(basecamp.coord_lat, basecamp.coord_long)
    if point_included_in_polygon?(@one_hour_polygon, center)
      distance_score = 0
    else
      distance_score = trip.distance_from(basecamp)
    end

    # Compute final score
    score = weather_score * [(itinerary_count / (2 * trip.duration)), 4].min - (distance_score / 10) - avalanche_score ** 2
  end
end
