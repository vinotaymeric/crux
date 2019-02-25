class CreateBasecamps < ActiveRecord::Migration[5.2]
  def change
    create_table :basecamps do |t|
      t.string :name
      t.string :location
      t.float :coord_long
      t.float :coord_lat
      t.references :activity, foreign_key: true
      t.references :trip, foreign_key: true
      t.references :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
