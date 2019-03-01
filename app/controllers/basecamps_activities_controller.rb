class BasecampsActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

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
    ## Dynamic mountain range to be done
    @mountain_range = MountainRange.first
    @basecamp_activity = BasecampsActivity.find(params[:id])
    @basecamp = @basecamp_activity.basecamp
    @activity = @basecamp_activity.activity
    @itineraries = @basecamp_activity.itineraries
  end
end
