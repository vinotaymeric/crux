class DropTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :area_basecamps
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
