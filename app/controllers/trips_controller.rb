class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :new, :create]

  def new
    if current_user != nil
      @user_activities = current_user.user_activities
    else
      @user_activities = []
    end
    @trip = Trip.new
  end

  def index
    @trips = Trip.where(user_id: current_user.id).order('trips.created_at desc')
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    @trip.save!
    redirect_to root_path
  end

  def show
  end

  def update
  end

  def edit
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :title)
  end

end
