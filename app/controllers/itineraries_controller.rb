class ItinerariesController < ApplicationController
  before_action :init_mark_down_parser, only: [:show, :index]

  def index
    @user = current_user
    @followed_itineraries = current_user.itineraries
    @follow = Follow.new
    @favorite = FavoriteItinerary.new
    @trip = Trip.new

    if params[:query].present? && !params[:query].blank?
        @itineraries = Itinerary.where("name ILIKE ?", "%#{params[:query]}%")[0..10]
        @itineraries = @itineraries.to_a.sort_by { |itinerary| itinerary.score}.reverse
        respond_to do |format|
          format.js { render partial: 'shared/search-results', locals: {search_result_itineraries: @itineraries, follow: @follow, followed_itineraries: @followed_itineraries, user: @user}}
        end
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @itinerary.update_recent_conditions
  end
end
