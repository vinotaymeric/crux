class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :init_mark_down_parser, only: [:show, :index]

  def index
     @itineraries =Itinerary.all.order("number_of_outing desc")[0..100]
     # paginate(page: params[:page], per_page: 12)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
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
