class AddUniversalDifficultyToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :universal_difficulty, :string
  end
end
