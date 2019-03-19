class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.float :coord_long
      t.float :coord_lat
      t.string :city_inhab
      t.string :code_insee
      t.string :geoname
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
