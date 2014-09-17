require 'test_helper'

class V1::SellersControllerTest < ActionController::TestCase
  setup do
    @v1_seller = v1_sellers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v1_sellers)
  end

  test "should create v1_seller" do
    assert_difference('V1::Seller.count') do
      post :create, v1_seller: { address: @v1_seller.address, api_key: @v1_seller.api_key, latitude: @v1_seller.latitude, longitude: @v1_seller.longitude, phone: @v1_seller.phone, rating: @v1_seller.rating }
    end

    assert_response 201
  end

  test "should show v1_seller" do
    get :show, id: @v1_seller
    assert_response :success
  end

  test "should update v1_seller" do
    put :update, id: @v1_seller, v1_seller: { address: @v1_seller.address, api_key: @v1_seller.api_key, latitude: @v1_seller.latitude, longitude: @v1_seller.longitude, phone: @v1_seller.phone, rating: @v1_seller.rating }
    assert_response 204
  end

  test "should destroy v1_seller" do
    assert_difference('V1::Seller.count', -1) do
      delete :destroy, id: @v1_seller
    end

    assert_response 204
  end
end
