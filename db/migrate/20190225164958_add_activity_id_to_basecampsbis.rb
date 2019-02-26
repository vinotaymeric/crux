class AddActivityIdToBasecampsbis < ActiveRecord::Migration[5.2]
  def change
    add_column :basecamps, :activity_id, :references
  end
end
