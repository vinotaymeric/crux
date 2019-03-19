class AddWeatherToArea < ActiveRecord::Migration[5.2]
  def change
    add_reference :areas, :weather, foreign_key: true
  end
end
