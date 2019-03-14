class CreateOutings < ActiveRecord::Migration[5.2]
  def change
    create_table :outings do |t|
      t.references :itinerary, foreign_key: true
      t.string :date

      t.timestamps
    end
  end
end
