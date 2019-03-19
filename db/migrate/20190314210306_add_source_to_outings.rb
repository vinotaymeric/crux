class AddSourceToOutings < ActiveRecord::Migration[5.2]
  def change
    add_column :outings, :source_id, :integer
  end
end
