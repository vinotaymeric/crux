class MessagesController < ApplicationController
  before_action :load_entities

  def create
    @message = Message.create! user: current_user,
                               trip: @trip,
                               content: params.dig(:message, :content)

    TripChannel.broadcast_to @trip, @message
  end

  private

  def load_entities
    @trip = Trip.find(params[:trip_id])
  end
end
