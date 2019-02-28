class AddCountToBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :basecamps_activities, :itinerary_count, :integer
  end
end
