require 'test_helper'

class PricesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "should get show" do
    sign_in users(:one)
    get :show, id: 1
    assert_response :success
  end

end
