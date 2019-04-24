class AddSlugToItinerary < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :slug, :string
  end
end
