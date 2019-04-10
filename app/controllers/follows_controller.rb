class FollowsController < ApplicationController
  before_action :init_mark_down_parser, only: :index

  def create
    Follow.create!(follow_params) unless current_user.itineraries.include?(Itinerary.find(follow_params[:itinerary_id].to_s))
  end

  def index
    @user = current_user
    @itineraries = @user.itineraries
    @follow = Follow.new
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.delete
    flash[:notice] = "Tu n'auras plus d'update sur cet itinéraire."
    redirect_back(fallback_location: root_path)
  end

  private

  def follow_params
    params.require(:follow).permit(:user_id, :itinerary_id)
  end
end
