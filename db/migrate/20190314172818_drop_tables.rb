class DropTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :basecamps_activities_itineraries
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
