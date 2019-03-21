class RequestsController < ApplicationController
  def create
    redirect_to new_user_registration_path and return if current_user.nil?
    trip = Trip.find(params[:trip_id])
    Request.create!(trip: trip)
    flash[:notice] = 'On se met au travail, et on revient vite vers toi.'
  end
end
