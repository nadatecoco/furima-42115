require 'test_helper'

class BuyersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get buyers_index_url
    assert_response :success
  end

  test 'should get create' do
    get buyers_create_url
    assert_response :success
  end
end
