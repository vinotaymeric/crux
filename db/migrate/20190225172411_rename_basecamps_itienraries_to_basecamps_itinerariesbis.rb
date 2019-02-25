class RenameBasecampsItienrariesToBasecampsItinerariesbis < ActiveRecord::Migration[5.2]
  def change
    rename_table :basecamps_itienraries, :basecamps_itineraries
  end
end
