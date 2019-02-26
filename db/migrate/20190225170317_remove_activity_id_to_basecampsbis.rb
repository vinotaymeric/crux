class RemoveActivityIdToBasecampsbis < ActiveRecord::Migration[5.2]
  def change
    remove_column :basecamps, :activity_id, :bigint
  end
end
