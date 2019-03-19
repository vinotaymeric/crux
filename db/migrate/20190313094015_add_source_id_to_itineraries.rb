class AddSourceIdToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :source_id, :integer
  end
end
