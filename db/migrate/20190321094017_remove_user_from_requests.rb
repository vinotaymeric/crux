class RemoveUserFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_reference :requests, :user, foreign_key: true
  end
end
