class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :init_mark_down_parser, only: :show

  def index
    # basecamp = params[:basecamp_id]
    # @itineraries = Itinerary.where(basecamp_id: basecamp.id)
    #@itineraries = Itinerary.where(activity_id: 13)[-50..-1]

   #@itineraries =Itinerary.where(activity_id: 13).paginate(page: params[:page], per_page: 12).order("difficulty asc")
   get_and_show_itineraries
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
    @itineraries = Itinerary.where(activity_id: 13).paginate(page: params[:page], per_page: 15).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

end
