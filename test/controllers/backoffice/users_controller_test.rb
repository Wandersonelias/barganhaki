require 'test_helper'

class Backoffice::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backoffice_users_index_url
    assert_response :success
  end

end
