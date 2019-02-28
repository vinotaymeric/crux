class CreateBasecampsActivitiesItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :basecamps_activities_itineraries do |t|
      t.references :itinerary, foreign_key: true
      t.references :basecamps_activity, foreign_key: true

      t.timestamps
    end
  end
end
