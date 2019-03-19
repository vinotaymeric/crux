class CreateAreaBasecamps < ActiveRecord::Migration[5.2]
  def change
    create_table :area_basecamps do |t|
      t.references :area, foreign_key: true
      t.references :basecamp, foreign_key: true

      t.timestamps
    end
  end
end
