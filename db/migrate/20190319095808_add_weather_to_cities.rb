class AddWeatherToCities < ActiveRecord::Migration[5.2]
  def change
    add_reference :cities, :weather, foreign_key: true
  end
end
