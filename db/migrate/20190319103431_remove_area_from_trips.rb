class RemoveAreaFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_reference :trips, :area, foreign_key: true
  end
end
