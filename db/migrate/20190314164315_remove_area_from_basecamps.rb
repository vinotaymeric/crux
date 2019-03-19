class RemoveAreaFromBasecamps < ActiveRecord::Migration[5.2]
  def change
    remove_reference :basecamps, :area, foreign_key: true
  end
end
