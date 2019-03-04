class AddSubscribedToTripsBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :trips_basecamps_activities, :subscribed, :boolean
  end
end
