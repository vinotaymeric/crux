class AddSubscribeddefaultvalueToTripsBasecampsActivities < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:trips_basecamps_activities, :subscribed, false)
  end
end
