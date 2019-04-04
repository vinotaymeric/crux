class CreateTripActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_activities do |t|
      t.references :trip, foreign_key: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
