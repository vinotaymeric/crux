class AddSourceIdToHuts < ActiveRecord::Migration[5.2]
  def change
    add_column :huts, :source_id, :integer
  end
end
