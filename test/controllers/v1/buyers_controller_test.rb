require 'test_helper'

class V1::BuyersControllerTest < ActionController::TestCase
  setup do
    @v1_buyer = v1_buyers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v1_buyers)
  end

  test "should create v1_buyer" do
    assert_difference('V1::Buyer.count') do
      post :create, v1_buyer: {  }
    end

    assert_response 201
  end

  test "should show v1_buyer" do
    get :show, id: @v1_buyer
    assert_response :success
  end

  test "should update v1_buyer" do
    put :update, id: @v1_buyer, v1_buyer: {  }
    assert_response 204
  end

  test "should destroy v1_buyer" do
    assert_difference('V1::Buyer.count', -1) do
      delete :destroy, id: @v1_buyer
    end

    assert_response 204
  end
end
