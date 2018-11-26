require 'test_helper'

class Site::CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get site_companies_show_url
    assert_response :success
  end

end
