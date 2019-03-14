class AddHutToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_reference :itineraries, :hut, foreign_key: true
  end
end
