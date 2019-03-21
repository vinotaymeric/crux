class AddTripToRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :trip, foreign_key: true
  end
end
