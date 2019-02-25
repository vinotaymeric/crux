class CreateTripsBasecamps < ActiveRecord::Migration[5.2]
  def change
    create_table :trips_basecamps do |t|
      t.references :trip, foreign_key: true
      t.references :basecamp, foreign_key: true

      t.timestamps
    end
  end
end
