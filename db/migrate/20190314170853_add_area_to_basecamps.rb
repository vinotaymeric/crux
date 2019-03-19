class AddAreaToBasecamps < ActiveRecord::Migration[5.2]
  def change
    add_reference :basecamps, :area, foreign_key: true
  end
end
