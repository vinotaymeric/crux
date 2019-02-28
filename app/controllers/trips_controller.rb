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
    redirect_to root_path
  end

  def show
    # Pour l'instant on les affiche tous, il faudra ajouter les conditions de localisations/ météo / activités / niveau
    @basecamps = Basecamp.all


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
