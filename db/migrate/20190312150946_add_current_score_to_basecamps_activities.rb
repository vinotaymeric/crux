class AddCurrentScoreToBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :basecamps_activities, :current_score, :integer
  end
end
