class AddTempScoreToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :temp_score, :float
  end
end
