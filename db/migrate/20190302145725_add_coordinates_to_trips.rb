class AddCoordinatesToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :coord_lat, :float
    add_column :trips, :coord_long, :float
  end
end
