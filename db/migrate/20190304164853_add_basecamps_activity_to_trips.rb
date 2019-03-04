class AddBasecampsActivityToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :basecamps_activity, foreign_key: true
  end
end
