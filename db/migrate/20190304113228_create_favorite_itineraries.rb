class CreateFavoriteItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_itineraries do |t|
      t.references :trip, foreign_key: true
      t.references :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
