require 'test_helper'

class AdminUsers::MicropostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get public_on" do
    get :public_on
    assert_response :success
  end

  test "should get public_off" do
    get :public_off
    assert_response :success
  end

end
