require 'test_helper'

class RevisesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:revises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create revise" do
    assert_difference('Revise.count') do
      post :create, revise: { date_begin: '2014-01-01', date_end: '2014-02-01', distributor_id: 3, memo: 'memo memo' }
    end

    assert_redirected_to revise_path(assigns(:revise))
  end

  test "should show revise" do
    get :show, id: 1
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: 1
    assert_response :success
  end

  test "should update revise" do
    patch :update, id: 1, revise: { date_begin: @revise.date_begin, date_end: @revise.date_end, deleted_at: @revise.deleted_at, distributor_id: @revise.distributor_id, memo: @revise.memo }
    assert_redirected_to revise_path(assigns(:revise))
  end

  test "should destroy revise" do
    assert_difference('Revise.count', -1) do
      delete :destroy, id: 1
    end

    assert_redirected_to revises_path
  end
end
