class RemovegeonameFromBasecamps < ActiveRecord::Migration[5.2]
  def change
    remove_column :basecamps, :code_insee
    remove_column :basecamps, :geoname
    remove_column :basecamps, :city_inhab
    remove_column :basecamps, :activity_id
  end
end
