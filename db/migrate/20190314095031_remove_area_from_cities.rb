class RemoveAreaFromCities < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cities, :area, foreign_key: true
  end
end
