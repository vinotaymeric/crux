class ItinerariesController < ApplicationController
  before_action :init_mark_down_parser, only: [:show, :index]

  def index
    @user = current_user
    @followed_itineraries = current_user.itineraries
    @follow = Follow.new
    @best_itineraries = best_itineraries_for_this_user

    if params[:query].present? && !params[:query].blank?
        @itineraries = Itinerary.where("name ILIKE ?", "%#{params[:query]}%")[0..10]
        @itineraries = @itineraries.to_a.sort_by { |itinerary| itinerary.score}.reverse
        respond_to do |format|
          format.js { render partial: 'shared/search-results', locals: {search_result_itineraries: @itineraries, follow: @follow, followed_itineraries: @followed_itineraries, user: @user, favorite: nil, trip: nil}}
        end
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @itinerary.update_recent_conditions
  end

  private

  def best_itineraries_for_this_user
    user_activities =  @user.user_activities.where.not(level: nil)
    itineraries = []
    user_activities.each do |user_activity|
      itineraries << user_activity.itineraries.where('score >= 1').to_a
    end
    itineraries.flatten.sort_by(&:score).reverse[0..9]
    # user_activities.map { |user_activity| user_activity.itineraries}.flatten
  end
end
