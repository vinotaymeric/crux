class RequestsController < ApplicationController
  def create
    if current_user.nil?
      flash[:notice] = "Inscris-toi pour qu'on puisse te partager notre super programme."
      redirect_to new_user_registration_path and return
    end

    trip = Trip.find(params[:trip_id])

    if Request.find_by(trip_id: trip.id).nil?
      Request.create!(trip: trip)
      flash[:notice] = "On te concocte un programme aux petits oignons."
    else
      flash[:notice] = "On fait au plus vite, détends-toi ;)"
    end
    redirect_back(fallback_location: root_path)
  end
end
