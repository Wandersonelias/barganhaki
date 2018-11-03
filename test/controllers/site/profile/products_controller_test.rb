require 'test_helper'

class Site::Profile::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_profile_products_index_url
    assert_response :success
  end

end
