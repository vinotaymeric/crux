class DropTables4 < ActiveRecord::Migration[5.2]
  def up
    drop_table :itinerary_jsons
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
