class AddDiffToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :temp_score, :float
    add_column :cities, :temp_activity, :string
  end
end
