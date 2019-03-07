class AddCodeinseeToBasecamp < ActiveRecord::Migration[5.2]
  def change
    add_column :basecamps, :code_insee, :string
    add_column :basecamps, :geoname_id, :string
  end
end
