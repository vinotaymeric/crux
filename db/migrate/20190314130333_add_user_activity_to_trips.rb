class AddUserActivityToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :user_activity, foreign_key: true
  end
end
