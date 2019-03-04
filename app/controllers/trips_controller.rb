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
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location, :validated)
  end
end
