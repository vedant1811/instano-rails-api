require 'test_helper'

class V1::DevicesControllerTest < ActionController::TestCase
  setup do
    @v1_device = v1_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v1_devices)
  end

  test "should create v1_device" do
    assert_difference('V1::Device.count') do
      post :create, v1_device: {  }
    end

    assert_response 201
  end

  test "should show v1_device" do
    get :show, id: @v1_device
    assert_response :success
  end

  test "should update v1_device" do
    put :update, id: @v1_device, v1_device: {  }
    assert_response 204
  end

  test "should destroy v1_device" do
    assert_difference('V1::Device.count', -1) do
      delete :destroy, id: @v1_device
    end

    assert_response 204
  end
end
