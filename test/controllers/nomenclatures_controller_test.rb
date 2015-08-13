require 'test_helper'

class NomenclaturesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @nomenclature = nomenclatures(:one)
  end

  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:nomenclatures)
  end

  test "should get new" do
    sign_in users(:one)
    get :new
    assert_response :success
  end

  test "should create nomenclature" do
    user = User.create({email: "logist@test.com", password: "acs", password_confirmation: "acs"})
    user.add_role :logist
    sign_in(user)
    assert_difference('Nomenclature.count') do
      post :create, nomenclature: { name: 'one', partner_number: '01' } 
    end

    assert_redirected_to nomenclature_path(assigns(:nomenclature))
  end

  test "should show nomenclature" do
    sign_in users(:one)
    get :show, id: @nomenclature
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get :edit, id: @nomenclature
    assert_response :success
  end

  test "should update nomenclature" do
    sign_in users(:one)
    patch :update, id: 1, nomenclature: { }
    assert_redirected_to nomenclature_path(assigns(:nomenclature))
  end

  test "should destroy nomenclature" do
    assert_difference('Nomenclature.count', -1) do
      delete :destroy, id: @nomenclature
    end

    assert_redirected_to nomenclatures_path
  end
end
