class AddContentToOutings < ActiveRecord::Migration[5.2]
  def change
    add_column :outings, :content, :text
  end
end
