class AddColumnsToMountainRanges < ActiveRecord::Migration[5.2]
  def change
    add_column :mountain_ranges, :coord_lat, :float
    add_column :mountain_ranges, :coord_long, :float
    add_column :mountain_ranges, :bra_date, :Date
  end
end
# toto