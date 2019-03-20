class TripsController < ApplicationController
  before_action :authenticate_user!, only: :update

  def new
    user = current_or_guest_user

    @expert_activities_ids = Activity.expert_activities
    @user_activities = user.user_activities.where.not(activity_id: @expert_activities_ids)
    @unset_activities = @user_activities.where(level: nil)
    @set_activities = @user_activities.where('level IS NOT NULL')

    @trip = Trip.new
  end

  def index
    @trips = current_or_guest_user.trips.reverse
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_or_guest_user
    @trip.save!
    redirect_to trip_cities_path(@trip)
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
