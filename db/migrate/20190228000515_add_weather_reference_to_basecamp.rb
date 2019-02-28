class AddWeatherReferenceToBasecamp < ActiveRecord::Migration[5.2]
  def change
    add_reference :basecamps, :weather, foreign_key: true
  end
end
