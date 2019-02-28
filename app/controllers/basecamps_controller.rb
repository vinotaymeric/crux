class BasecampsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @basecamps = Basecamp.all
    # Pour l'instant on les affiche tous, il faudra ajouter les conditions de localisations/ météo / activités / niveau
    # if params[:location].present? && params[:activity].present?
    #   @basecamps = Basecamp.near(params[:location], 300).order("distance")
    #   @basecamps = @basecamps.select { |basecamp| Basecamp.activities.include?(params[:activity]) }
    # else
    #   @basecamps = Basecamp.where(basecamp_id: basecamp.id)
    # end

  end

  def show
    @basecamp = Basecamp.find(params[:id])
    @itineraries = @basecamp.itineraries
  end
end
