class CreateMountainRanges < ActiveRecord::Migration[5.2]
  def change
    create_table :mountain_ranges do |t|
      t.string :name
      t.string :rosace_url
      t.string :fresh_snow_url
      t.string :snow_image_url
      t.string :snow_quality
      t.string :stability

      t.timestamps
    end
  end
end
