class AddCityInhabitantsToBasecamps < ActiveRecord::Migration[5.2]
  def change
    add_column :basecamps, :city_inhab, :integer
  end
end
