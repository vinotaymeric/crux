class AddMoutainRangeReferenceToBasecamps < ActiveRecord::Migration[5.2]
  def change
    add_reference :basecamps, :mountain_range, foreign_key: true
  end
end
