require 'test_helper'

class HeadcountsControllerTest < ActionDispatch::IntegrationTest
  test "should get new_entrance" do
    get headcounts_new_entrance_url
    assert_response :success
  end

  test "should get new_exit" do
    get headcounts_new_exit_url
    assert_response :success
  end

end
