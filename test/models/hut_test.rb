require 'test_helper'

class HutTest < ActiveSupport::TestCase
  test "should not save hut without name" do
    hut = Hut.new
    assert_not hut.save, "testing test"
  end
end
