class BasecampsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    # if params[:location].present? && params[:activity].present?
    #   @basecamps = Basecamp.near(params[:location], 300).order("distance")
    #   @basecamps = @basecamps.select { |basecamp| Basecamp.activities.include?(params[:activity]) }
    # else
    #   @basecamps = Basecamp.where(basecamp_id: basecamp.id)
    # end
    @basecamps = Basecamp.all
  end

  def show
    @basecamp = Basecamp.find(params[:id])
  end
end
