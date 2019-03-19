class RemoveBasecampsActivityFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_reference :trips, :basecamps_activity, foreign_key: true
  end
end
