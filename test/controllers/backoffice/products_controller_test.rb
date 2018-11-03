require 'test_helper'

class Backoffice::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backoffice_products_index_url
    assert_response :success
  end

end
