class MessagesController < ApplicationController
  before_action :load_entities

  def create
    @message = Message.create! user: current_user,
                               trip: @trip,
                               content: params[:id]
  end

  private

  def load_entities
    @trip = Trip.find params[:trip_id]
  end
end
