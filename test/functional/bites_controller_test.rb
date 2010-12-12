require 'test_helper'

class BitesControllerTest < ActionController::TestCase
  setup do
    @bite = bites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bite" do
    assert_difference('Bite.count') do
      post :create, :bite => @bite.attributes
    end

    assert_redirected_to bite_path(assigns(:bite))
  end

  test "should show bite" do
    get :show, :id => @bite.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bite.to_param
    assert_response :success
  end

  test "should update bite" do
    put :update, :id => @bite.to_param, :bite => @bite.attributes
    assert_redirected_to bite_path(assigns(:bite))
  end

  test "should destroy bite" do
    assert_difference('Bite.count', -1) do
      delete :destroy, :id => @bite.to_param
    end

    assert_redirected_to bites_path
  end
end
