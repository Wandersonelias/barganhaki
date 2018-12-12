require 'test_helper'

class LancamentoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lancamento_index_url
    assert_response :success
  end

end
