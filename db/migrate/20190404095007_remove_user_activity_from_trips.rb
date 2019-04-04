class RemoveUserActivityFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_reference :trips, :user_activity, foreign_key: true
  end
end
