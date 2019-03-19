class DropTables2 < ActiveRecord::Migration[5.2]
  def up
    drop_table :trips_basecamps_activities
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
