class CreateTripsBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :trips_basecamps_activities do |t|
      t.references :basecamps_activity, foreign_key: true
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
