class RemoveWeatherFromBasecamp < ActiveRecord::Migration[5.2]
  def change
    remove_reference :basecamps, :weather, foreign_key: true
  end
end
