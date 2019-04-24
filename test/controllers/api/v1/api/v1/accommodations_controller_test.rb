require 'test_helper'

class Api::V1::Api::V1::AccommodationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_api_v1_accommodations_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_api_v1_accommodations_show_url
    assert_response :success
  end

end
