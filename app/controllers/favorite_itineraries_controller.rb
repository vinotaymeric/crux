class FavoriteItinerariesController < ApplicationController
  def create
    @favorite = FavoriteItinerary.new(favorite_params)
    @favorite.save!
  end

  def destroy
    itinerary = Itinerary.find(params[:id])
    trip = Trip.find(params[:trip_id])
    favorite_itinerary = FavoriteItinerary.where(trip_id: trip.id, itinerary_id: itinerary.id)
    favorite_itinerary[0].destroy!
    redirect_back(fallback_location: root_path)
  end

  def favorite_params
    params.require(:favorite_itinerary).permit(:trip_id, :itinerary_id)
  end
end
