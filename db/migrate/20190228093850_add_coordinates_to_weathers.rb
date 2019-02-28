class AddCoordinatesToWeathers < ActiveRecord::Migration[5.2]
  def change
    add_column :weathers, :forecast, :json
  end
end
