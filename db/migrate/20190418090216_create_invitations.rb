class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :trip, foreign_key: true
      t.string :mailed_to

      t.timestamps
    end
  end
end
