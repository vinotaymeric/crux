class RemoveLocationFromBasecamps < ActiveRecord::Migration[5.2]
  def change
    remove_column :basecamps, :location, :string
  end
end
