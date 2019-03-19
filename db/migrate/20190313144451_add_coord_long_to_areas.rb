class AddCoordLongToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :coord_long, :float
  end
end
