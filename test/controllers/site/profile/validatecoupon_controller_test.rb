require 'test_helper'

class Site::Profile::ValidatecouponControllerTest < ActionDispatch::IntegrationTest
  test "should get verifyvalidity" do
    get site_profile_validatecoupon_verifyvalidity_url
    assert_response :success
  end

end
