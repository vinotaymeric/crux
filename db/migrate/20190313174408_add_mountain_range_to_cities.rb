class AddMountainRangeToCities < ActiveRecord::Migration[5.2]
  def change
    add_reference :cities, :mountain_range, foreign_key: true
  end
end
