class RenameGeonameIdToGeoname < ActiveRecord::Migration[5.2]
  def change
    rename_column :basecamps, :geoname_id, :geoname
  end
end
