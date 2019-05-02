class TripsController < ApplicationController
  before_action :store_invitation_token
  before_action :empty_top_cities
  before_action :authenticate_user!, only: :show
  before_action :check_that_user_is_participant, only: :show

  def new
    @user_activities = current_or_guest_user.user_activities
                                            .where.not(activity_id: Activity.expert_activities)
    @trip = Trip.new
  end

  def show
    trip = Trip.find(params[:id])

    if trip.validated?
      redirect_to trip_city_trip_activity_path(trip, trip.city, trip.trip_activity)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @trips = current_or_guest_user.trips.reverse
  end

  def create
    dates_to_eng(params)
    @trip = Trip.new(trip_params)
    @trip.user = current_or_guest_user
    @trip.save!

    # Add current user as participant to the trip
    Participant.create!(user: current_or_guest_user, trip: @trip)

    # Create trip_activities so that if the user changes its profile it wont change the results
    current_or_guest_user.user_activities.where.not(level: nil).each do |user_activity|
      TripActivity.create!(trip: @trip, activity: user_activity.activity, level: user_activity.level)
    end

    redirect_to trip_cities_path(@trip)
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    flash[:notice] = "La sortie a été supprimée."
    redirect_back(fallback_location: root_path)
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location, :validated)
  end

  def store_invitation_token
    session[:invitation_token] = params[:invitation_token]
  end

  def check_that_user_is_participant
    trip = Trip.find(params[:id])

    unless trip.users.include?(current_user)
      flash[:alert] = "Tu n'es pas invité sur cette sortie."
      redirect_to root_path
    end
  end

  # Some logic to allow french langage within the calendar

  FR_TO_EN = [%w[Janvier January],
              %w[Février February],
              %w[Mars March],
              %w[Avril April],
              %w[Mai May],
              %w[Juin June],
              %w[Juillet July],
              %w[Août August],
              %w[Septembre September],
              %w[Octobre October],
              %w[Novembre November],
              %w[Décembre December],
              %w[Dim Sun],
              %w[Lun Mon],
              %w[Mar Tue],
              %w[Mer Wed],
              %w[Jeu Thu],
              %w[Ven Fri],
              %w[Sam Sat]]

  def date_to_eng(fr_stringified_date)
    eng_date = fr_stringified_date.split(' ').map! do |word|
      if word[0].match?(/[a-zA-Z]/)
        FR_TO_EN.select { |coupled_array| coupled_array[0] == word }[0][1]
      else word
      end
    end
    eng_date.join(' ')
  end

  def dates_to_eng(params)
    params[:trip][:start_date] = date_to_eng(params[:trip][:start_date])
    params[:trip][:end_date] = date_to_eng(params[:trip][:end_date])
    params
  end

  def empty_top_cities
    session[:cities_activities] = nil
  end
end
