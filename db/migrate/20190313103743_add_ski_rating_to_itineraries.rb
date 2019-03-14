class AddSkiRatingToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :ski_rating, :string
  end
end
