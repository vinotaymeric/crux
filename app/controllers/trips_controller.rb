class TripsController < ApplicationController
  def new
    @user_activities = current_user.nil? ? [] : current_user.user_activities.order(:activity_id)
    @trip = Trip.new
  end

  def index
    @trips = current_user.trips.reverse
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    # !!! This is a very dirty hack, I don't know why but the trip has to have a basecamp_activity
    @trip.basecamps_activity = BasecampsActivity.find(6456)
    # Improve if you can ;)
    @trip.save!
    redirect_to trip_basecamps_activities_path(@trip)
  end

  def show
  end

  def update
    @trip = Trip.find(params[:id])

    if @trip.validated
      @trip.validated = false
    else
      @trip.validated = true
    end

    @trip.save!

    if @trip.validated
      flash[:notice] = 'Vos itinéraires sont disponibles en mode offline'
    end

    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location, :validated)
  end
end
