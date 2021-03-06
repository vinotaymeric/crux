class TripActivitiesController < ApplicationController
  before_action :init_mark_down_parser, only: :show
  before_action :get_trip_and_city

  def show
    @trip_activity = TripActivity.find(params[:id])
    @activity = Activity.find(@trip_activity.activity_id)
    @mountain_range = @city.mountain_range
    @favorite_itinerary = FavoriteItinerary.new
    @invitation = Invitation.new
    @message = Message.new

    if params[:query].present? && !params[:query].blank?
      @itineraries = Itinerary.where("name ILIKE ?", "%#{params[:query]}%")[0..10]
      respond_to do |format|
        format.js { render partial: 'shared/search-results', locals: {search_result_itineraries: @itineraries, favorite: @favorite_itinerary, trip: @trip, follow: nil, followed_itineraries: nil, user: nil}}
      end
    elsif @trip.validated
      @itineraries = @trip.itineraries.distinct.order(picture_url: :asc)
    else
      @itineraries = @city.itineraries.where(activity_id: @activity.id, universal_difficulty: @trip_activity.level.downcase)
    end

    @itineraries = @itineraries.to_a.sort_by { |itinerary| itinerary.score}.reverse

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
    redirect_to new_user_registration_path and return if current_user.nil?
    trip_activity = TripActivity.find(params[:id])

    if @trip.validated
      @trip.validated = false
    else
      @trip.validated = true
      @trip.city = @city
      @trip.trip_activity = trip_activity
    end

    @trip.save!

    flash[:notice] = "Tes itinéraires sont sauvegardés, directement accessibles depuis 'Mes sorties'" if @trip.validated
    redirect_back(fallback_location: root_path)
  end

  private

  def user_activity_params
    params.require(:user_activity).permit(:level, :activity_id)
  end

  def get_trip_and_city
    @trip = Trip.find(params[:trip_id])
    @city = City.find(params[:city_id])
  end
end
