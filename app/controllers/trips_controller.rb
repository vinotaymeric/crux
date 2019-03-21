class TripsController < ApplicationController

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

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location, :validated)
  end

end
