class AddLevelToTripActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :trip_activities, :level, :string
  end
end
