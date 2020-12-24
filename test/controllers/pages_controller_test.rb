require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get my_counters" do
    get pages_my_counters_url
    assert_response :success
  end

  test "should get user_page" do
    get pages_user_page_url
    assert_response :success
  end

  test "should get admin_page" do
    get pages_admin_page_url
    assert_response :success
  end

end
