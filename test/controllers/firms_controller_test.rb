require "test_helper"

class FirmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get firms_index_url
    assert_response :success
  end

  test "should get select" do
    get firms_select_url
    assert_response :success
  end
end
