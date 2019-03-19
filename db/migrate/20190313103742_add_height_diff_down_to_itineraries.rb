class AddHeightDiffDownToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :height_diff_down, :string
  end
end
