class BasecampsActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :init_mark_down_parser, only: :show

  def index
    @basecamps_activity = BasecampsActivity.all
    # Pour l'instant on les affiche tous, il faudra ajouter les conditions de localisations/ météo / activités / niveau
    # if params[:location].present? && params[:activity].present?
    #   @basecamps = Basecamp.near(params[:location], 300).order("distance")
    #   @basecamps = @basecamps.select { |basecamp| Basecamp.activities.include?(params[:activity]) }
    # else
    #   @basecamps = Basecamp.where(basecamp_id: basecamp.id)
    # end

  end

  def show
    @basecamp_activity = BasecampsActivity.find(params[:id])
    @basecamp = @basecamp_activity.basecamp
    @activity = @basecamp_activity.activity
    @mountain_range = @basecamp.mountain_range
    user_level_for_activity = current_user.user_activities.find_by(activity_id: @activity.id).level
    @itineraries = @basecamp_activity.itineraries.where(level: user_level_for_activity )[0..20]
    @favorite_itinerary = FavoriteItinerary.new
  end

  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

end
