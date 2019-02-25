class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.string :name
      t.text :content
      t.string :coord_x
      t.string :coord_y
      t.string :difficulty
      t.integer :elevation_max
      t.integer :height_diff_up
      t.string :engagement_rating
      t.string :equipment_rating
      t.string :orientations
      t.integer :number_of_outing
      t.string :picture_url
      t.float :coord_long
      t.float :coord_lat
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
