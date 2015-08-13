require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    sign_in users(:one)
  end
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: 1
    assert_response :success
  end

end
