require "test_helper"

class ProizvodiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get proizvodi_index_url
    assert_response :success
  end

  test "should get select" do
    get proizvodi_select_url
    assert_response :success
  end
end
