require 'test_helper'

class V1::QuotesControllerTest < ActionController::TestCase
  setup do
    @v1_quote = v1_quotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v1_quotes)
  end

  test "should create v1_quote" do
    assert_difference('V1::Quote.count') do
      post :create, v1_quote: { brands: @v1_quote.brands, buyer_id: @v1_quote.buyer_id, price_range: @v1_quote.price_range, search_string: @v1_quote.search_string }
    end

    assert_response 201
  end

  test "should show v1_quote" do
    get :show, id: @v1_quote
    assert_response :success
  end

  test "should update v1_quote" do
    put :update, id: @v1_quote, v1_quote: { brands: @v1_quote.brands, buyer_id: @v1_quote.buyer_id, price_range: @v1_quote.price_range, search_string: @v1_quote.search_string }
    assert_response 204
  end

  test "should destroy v1_quote" do
    assert_difference('V1::Quote.count', -1) do
      delete :destroy, id: @v1_quote
    end

    assert_response 204
  end
end
