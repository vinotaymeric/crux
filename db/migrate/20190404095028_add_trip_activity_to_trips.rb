class AddTripActivityToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :trip_activity, foreign_key: true
  end
end
