class TripChannel < ApplicationCable::Channel
  def subscribed
    trip = Trip.find(params[:trip_id])
    stream_from trip
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
