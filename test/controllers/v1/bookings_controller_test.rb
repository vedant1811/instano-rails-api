require 'test_helper'

class V1::BookingsControllerTest < ActionController::TestCase
  setup do
    @v1_booking = v1_bookings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v1_bookings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create v1_booking" do
    assert_difference('V1::Booking.count') do
      post :create, v1_booking: {  }
    end

    assert_redirected_to v1_booking_path(assigns(:v1_booking))
  end

  test "should show v1_booking" do
    get :show, id: @v1_booking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @v1_booking
    assert_response :success
  end

  test "should update v1_booking" do
    patch :update, id: @v1_booking, v1_booking: {  }
    assert_redirected_to v1_booking_path(assigns(:v1_booking))
  end

  test "should destroy v1_booking" do
    assert_difference('V1::Booking.count', -1) do
      delete :destroy, id: @v1_booking
    end

    assert_redirected_to v1_bookings_path
  end
end
