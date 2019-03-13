class AddBasecampToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_reference :itineraries, :basecamp, foreign_key: true
  end
end
