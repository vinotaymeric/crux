class ItinerariesController < ApplicationController
  before_action :init_mark_down_parser, only: [:show, :index]

  def index
    if params[:query].present? && !params[:query].blank?
        @itineraries = Itinerary.where("name ILIKE ?", "%#{params[:query]}%")[0..10]
        @itineraries = @itineraries.to_a.sort_by { |itinerary| itinerary.score}.reverse
        respond_to do |format|
          format.js { render partial: 'search-results', locals: {search_result_itineraries: @itineraries, favorite: @favorite_itinerary, trip: @trip}}
        end
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @itinerary.update_recent_conditions
  end

  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  private

  def get_and_show_itineraries
    @itineraries = Itinerary.where(activity_id: 13).paginate(:page => params[:page]).order('difficulty asc')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

end
