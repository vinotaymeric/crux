class UserActivitiesController < ApplicationController
  before_action :init_mark_down_parser, only: :show

  def update
    @user_activity = UserActivity.find_by(user: current_user, activity: user_activity_params[:activity_id])
    @user_activity.update!(user_activity_params)
    @user_activity.update!(level: nil) if @user_activity.level == "Pas intéressé"
    head 200
  end

  def show
    @area = Area.find(params[:area_id])
    @city = @area.city
    @trip = Trip.find(params[:trip_id])
    @user_activity = UserActivity.find(params[:id])
    @activity = Activity.find(@user_activity.activity_id)
    @mountain_range = @area.city.mountain_range

    if @trip.validated
      @itineraries = @trip.itineraries.distinct.order(picture_url: :asc)
    else
      @itineraries = @area.itineraries.where(activity_id: @activity.id ).order(picture_url: :asc)
    end

    @itineraries.sort_by! { |itinerary| itinerary.score}.reverse

    @favorite_itinerary = FavoriteItinerary.new

    # Mapbox
    @markers = @itineraries.map do |itinerary|
      {
        lng: itinerary.coord_long,
        lat: itinerary.coord_lat,
        infoWindow: render_to_string(partial: "info_iti", locals: { itinerary: itinerary }),
        image_url: helpers.asset_url('https://cdn.iconscout.com/icon/premium/png-256-thumb/mountain-233-793712.png')
      }
    end
  end

  def update_trip
    @trip = Trip.find(params[:trip_id])
    area = Area.find(params[:area_id])
    user_activity = UserActivity.find(params[:id])

    if @trip.validated
      @trip.validated = false
    else
      @trip.validated = true
      @trip.area = area
      @trip.user_activity = user_activity
    end

    @trip.save!

    if @trip.validated
      flash[:notice] = 'Vos itinéraires sont disponibles en mode offline'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def user_activity_params
    params.require(:user_activity).permit(:level, :activity_id)
  end
end
