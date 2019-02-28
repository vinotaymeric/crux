class CreateBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :basecamps_activities do |t|
      t.references :activity, foreign_key: true
      t.references :basecamp, foreign_key: true

      t.timestamps
    end
  end
end
