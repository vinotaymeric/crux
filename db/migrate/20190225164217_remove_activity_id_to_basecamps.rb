class RemoveActivityIdToBasecamps < ActiveRecord::Migration[5.2]
  def change
    remove_column :basecamps, :activity_id, :bigint
    remove_column :basecamps, :trip_id, :bigint
    remove_column :basecamps, :itinerary_id, :bigint
  end
end
