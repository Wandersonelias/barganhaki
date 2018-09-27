require 'test_helper'

class Site::Prefil::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_prefil_dashboard_index_url
    assert_response :success
  end

end
