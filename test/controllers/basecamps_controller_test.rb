require 'test_helper'

class BasecampsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get basecamps_index_url
    assert_response :success
  end

  test "should get show" do
    get basecamps_show_url
    assert_response :success
  end

end
