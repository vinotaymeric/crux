class FavoriteItinerariesController < ApplicationController
  def create
    @favorite = FavoriteItinerary.new(favorite_params)
    @favorite.save!
    # redirect_back(fallback_location: root_path)
  end

  def favorite_params
    params.require(:favorite_itinerary).permit(:trip_id, :itinerary_id)
  end
end
