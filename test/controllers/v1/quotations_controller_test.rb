require 'test_helper'

class V1::QuotationsControllerTest < ActionController::TestCase
  setup do
    @v1_quotation = v1_quotations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v1_quotations)
  end

  test "should create v1_quotation" do
    assert_difference('V1::Quotation.count') do
      post :create, v1_quotation: { description: @v1_quotation.description, name_of_product: @v1_quotation.name_of_product, price: @v1_quotation.price, seller_id: @v1_quotation.seller_id }
    end

    assert_response 201
  end

  test "should show v1_quotation" do
    get :show, id: @v1_quotation
    assert_response :success
  end

  test "should update v1_quotation" do
    put :update, id: @v1_quotation, v1_quotation: { description: @v1_quotation.description, name_of_product: @v1_quotation.name_of_product, price: @v1_quotation.price, seller_id: @v1_quotation.seller_id }
    assert_response 204
  end

  test "should destroy v1_quotation" do
    assert_difference('V1::Quotation.count', -1) do
      delete :destroy, id: @v1_quotation
    end

    assert_response 204
  end
end
