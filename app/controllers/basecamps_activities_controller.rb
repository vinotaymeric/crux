class BasecampsActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :init_mark_down_parser, only: :show

  def index
    @user = current_user
    @trip = Trip.find(params[:trip_id])

    # See how many itineraries match the user profile

    basecamps_activities = BasecampsActivity.select("basecamps_activities.*, COUNT(basecamps_activities_itineraries.itinerary_id) as nb_itineraries").joins(:itineraries)
      .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
      .where(user_activities: {user_id: current_user.id})
      .where("user_activities.level = itineraries.level")
      .group("basecamps_activities.id")
      .order("COUNT(basecamps_activities_itineraries.itinerary_id) DESC")
      .to_a


    # Compute score also considering weather and localisation

    basecamps_activities.sort_by! do |base|
      score = basecamp_activity_score(base.nb_itineraries, base.weather, @trip, @trip.distance_from(base.basecamp), base.basecamp.mountain_range.max_risk)
    end

    # Take only top

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
      @itineraries = @basecamp_activity.itineraries.where(level: user_level_for_activity )[0..20]
    end

    @favorite_itinerary = FavoriteItinerary.new
  end


  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def weather_day_score(forecast)
    # if condition checks that there it'a s good day : no wind, rain and good visi
    if forecast["day"]["maxwind_kph"] < 50 && forecast["day"]["totalprecip_mm"] < 2 && forecast["day"]["avgvis_km"] > 5
      d_score = 1
    else
      d_score = 0
    end
    # ap "toto"
    # ap d_score
    d_score
  end

  def weather_trip_score(start_date, end_date, weather)
    w_score = 0
    start_date.upto(end_date) do |date|
      weather.forecast.each do |forecast|
        w_score += weather_day_score(forecast) if (Date.parse forecast["date"]) == date
      end
    end
    w_score
  end

  def basecamp_activity_score(nb_itineraries, weather, trip, distance, avalanche)


    avalanche = 0 if avalanche.nil?
    w_score = weather_trip_score(trip.start_date, trip.end_date, weather)

    if nb_itineraries < 3 || distance > 500 || avalanche > 4
      score = -1000
    else
      score = [nb_itineraries, 15].min - (distance / 10) - 3 * avalanche + 7 * w_score
    end
    # ap "lol"
    # ap w_score
    return score
  end
end
