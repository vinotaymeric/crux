class RemoveDiverseFromBasecamps < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :favorite_activity
    remove_column :weathers, :weekend_score
  end
end
