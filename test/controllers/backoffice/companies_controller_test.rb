require 'test_helper'

class Backoffice::CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backoffice_companies_index_url
    assert_response :success
  end

end
