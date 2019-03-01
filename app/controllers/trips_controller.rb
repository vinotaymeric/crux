class TripsController < ApplicationController

  def new
    if current_user != nil
      @user_activities = current_user.user_activities
    else
      @user_activities = []
    end
    @trip = Trip.new
  end

  def index
    # @trips = Trip.where(user_id: current_user.id).order('trips.created_at desc')
    @trips = Trip.all
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    @trip.save!
    redirect_to trip_path(@trip)
  end

  def show
    @user = current_user
    @trip = Trip.find(params[:id])

    @basecamps_activities = BasecampsActivity.select("basecamps_activities.*, COUNT(basecamps_activities_itineraries.itinerary_id) as nb_itineraries").joins(:itineraries)
      .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
      .where(user_activities: {user_id: current_user.id})
      .where("user_activities.level = itineraries.level")
      .group("basecamps_activities.id")
      .order("COUNT(basecamps_activities_itineraries.itinerary_id) DESC")
      .limit(4)
  end

  def update
  end

  def edit
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location)
  end

end
