class RemoveDiffFromAreas < ActiveRecord::Migration[5.2]
  def change
    remove_column :areas, :temp_score, :string
    remove_column :areas, :temp_activity, :string
    remove_reference :areas, :weather, foreign_key: true
  end
end
