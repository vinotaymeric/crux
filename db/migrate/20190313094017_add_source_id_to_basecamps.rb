class AddSourceIdToBasecamps < ActiveRecord::Migration[5.2]
  def change
    add_column :basecamps, :source_id, :integer
  end
end
