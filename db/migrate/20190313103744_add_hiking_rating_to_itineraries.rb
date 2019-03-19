class AddHikingRatingToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :hiking_rating, :string
  end
end
