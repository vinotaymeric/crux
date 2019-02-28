class DropBasecampsItinerariesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :basecamps_itineraries
  end
end
