class AddScoreToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :score, :float
  end
end
