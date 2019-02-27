class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.integer :weekend_score

      t.timestamps
    end
  end
end
