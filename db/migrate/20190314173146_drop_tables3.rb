class DropTables3 < ActiveRecord::Migration[5.2]
  def up
    drop_table :basecamps_activities
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
