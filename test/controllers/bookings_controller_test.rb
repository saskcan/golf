require 'test_helper'

class BookingsControllerTest < ActionController::TestCase

   setup :login_as_amy

  setup do
    @booking = bookings(:amy_new_years)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post :create, booking: { time: @booking.time + 1.day, club_id: @booking.club_id }
    end

    assert_redirected_to bookings_path
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete :destroy, id: @booking
    end
    assert_redirected_to bookings_path
  end

  test "a user cannot destroy another user's booking" do
    @booking = bookings(:ben_new_years)
    assert_difference('Booking.count', 0) do
      delete :destroy, id: @booking
    end
  end
end