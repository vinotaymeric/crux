class TripChannel < ApplicationCable::Channel
  def subscribed
    trip = Trip.find params[:trip]
    stream_for trip
  end
end
