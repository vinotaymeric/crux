class AddCityToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :city, foreign_key: true
  end
end
