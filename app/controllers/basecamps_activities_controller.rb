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

    # Compute score also considering weather and localisation ater

    basecamps_activities.sort_by! do |base|
      score = basecamp_activity_score(base.nb_itineraries, base.weather.weekend_score, @trip.distance_from(base.basecamp))
    end

    # Take only top

    @basecamps_activities = basecamps_activities.reverse[0..50]

  end

  def show
    @basecamp_activity = BasecampsActivity.find(params[:id])
    @basecamp = @basecamp_activity.basecamp
    @activity = @basecamp_activity.activity
    @mountain_range = @basecamp.mountain_range
    user_level_for_activity = current_user.user_activities.find_by(activity_id: @activity.id).level
    @itineraries = @basecamp_activity.itineraries.where(level: user_level_for_activity )[0..20]
    @favorite_itinerary = FavoriteItinerary.new
    @trip = Trip.find(params[:trip_id])
  end


  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def basecamp_activity_score(nb_itineraries, weather, distance)
    if nb_itineraries < 3 || distance > 500 || weather < 0
      score = -1000
    else
      score = [Math.log(nb_itineraries), 15].min - (distance / 10)
    end
    return score
  end
end
