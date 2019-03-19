class CreateHuts < ActiveRecord::Migration[5.2]
  def change
    create_table :huts do |t|
      t.float :coord_long
      t.float :coord_lat
      t.string :name

      t.timestamps
    end
  end
end
