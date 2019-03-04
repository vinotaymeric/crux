class FavoriteItinerariesController < ApplicationController

  def create
    @favorite = FavoriteItinerary.new(favorite_params)
  end

  def trip_params
    params.require(:trip).permit(:trip_id, :itinerary_id)
  end
end
