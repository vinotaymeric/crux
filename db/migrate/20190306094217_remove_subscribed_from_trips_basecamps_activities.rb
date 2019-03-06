class RemoveSubscribedFromTripsBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips_basecamps_activities, :subscribed, :boolean
  end
end
