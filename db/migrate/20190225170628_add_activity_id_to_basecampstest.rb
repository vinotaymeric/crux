class AddActivityIdToBasecampstest < ActiveRecord::Migration[5.2]
  def change
    add_reference :basecamps, :activity, foreign_key: true
  end
end
