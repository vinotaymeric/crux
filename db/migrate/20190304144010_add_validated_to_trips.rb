class AddValidatedToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :validated, :boolean
  end
end
