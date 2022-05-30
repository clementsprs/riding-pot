require "test_helper"

class Host::RidesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get host_rides_new_url
    assert_response :success
  end

  test "should get create" do
    get host_rides_create_url
    assert_response :success
  end

  test "should get destroy" do
    get host_rides_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get host_rides_edit_url
    assert_response :success
  end

  test "should get update" do
    get host_rides_update_url
    assert_response :success
  end
end
