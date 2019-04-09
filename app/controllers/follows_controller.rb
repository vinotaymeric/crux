class FollowsController < ApplicationController
  before_action :init_mark_down_parser, only: :index

  def create
    # if @user.nil?
    #   flash[:notice] = "Inscris-toi pour pouvoir suivre les conditions de cet itinéraire."
    #   redirect_to new_user_registration_path and return
    # end
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

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end
end
