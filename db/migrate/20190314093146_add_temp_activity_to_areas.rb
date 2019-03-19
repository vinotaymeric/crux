class AddTempActivityToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :temp_activity, :string
  end
end
