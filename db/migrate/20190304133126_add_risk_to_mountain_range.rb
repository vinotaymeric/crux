class AddRiskToMountainRange < ActiveRecord::Migration[5.2]
  def change
    add_column :mountain_ranges, :max_risk, :integer
  end
end
