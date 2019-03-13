class CreateItineraryJsons < ActiveRecord::Migration[5.2]
  def change
    create_table :itinerary_jsons do |t|
      t.string :json

      t.timestamps
    end
  end
end
