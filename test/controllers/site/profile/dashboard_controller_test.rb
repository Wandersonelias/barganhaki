require 'test_helper'

class Site::Profile::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_profile_dashboard_index_url
    assert_response :success
  end

end
