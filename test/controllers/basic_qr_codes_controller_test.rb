require 'test_helper'

class BasicQrCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get basic_qr_codes_index_url
    assert_response :success
  end

end
