class TripsController < ApplicationController
  before_action :empty_top_cities

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
    dates_to_eng(params)
    @trip = Trip.new(trip_params)
    @trip.user = current_or_guest_user
    @trip.save!
    redirect_to trip_cities_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :location, :validated)
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
