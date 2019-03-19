class AddCoordLatToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :coord_lat, :float
  end
end
