class ItinerariesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  # before_action :init_mark_down_parser, only: :show

  def index
    basecamp = params[:basecamp_id]
    @itineraries = Itinerary.where(basecamp_id: basecamp.id)
  end

  def show
  end

  private

  # def init_mark_down_parser
  #   renderer = Redcarpet::Render::HTML.new(no_images: true)
  #   @markdown = Redcarpet::Markdown.new(renderer)
  # end
end
