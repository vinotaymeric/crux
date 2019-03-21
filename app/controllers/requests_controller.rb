class RequestsController < ApplicationController
  def create
    redirect_to new_user_registration_path and return if current_user.nil?
    trip = Trip.find(params[:trip_id])

    if Request.find_by(trip_id: trip.id).nil?
      Request.create!(trip: trip)
      flash[:notice] = "On se met au travail, et on revient vite vers toi."
    else
      flash[:notice] = "On fait au plus vite, détends-toi ;)"
    end
    redirect_back(fallback_location: root_path)
  end
end
