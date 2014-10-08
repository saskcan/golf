require 'test_helper'

class BookingTest < ActiveSupport::TestCase

	test "a booking must have a time" do
		assert_difference('Booking.count', 0) do
			Booking.create(user_id: users(:amy).id)
		end
	end

	test "a booking must have a user" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2015-01-01 17:00:00"))
		end
	end

	test "a booking cannot be for before 9:00 am" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2014-12-01 08:00:00"), user_id: users(:amy).id)
		end
	end

	test "a booking cannot be for after 5:00 pm" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2014-12-01 17:00:01"), user_id: users(:amy).id)
		end

		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2014-12-01 17:20:00"), user_id: users(:amy).id)
		end

		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2014-12-01 18:00:00"), user_id: users(:amy).id)
		end
	end

	test "a booking must be at 0, 20 or 40 minutes of the hour" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2015-01-01 9:00:01"), user_id: users(:amy).id)
		end

		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2015-01-01 9:01:01"), user_id: users(:amy).id)
		end
	end

	test "a valid booking can be made" do
		assert_difference('Booking.count', 1) do
			Booking.create(time: DateTime.parse("2015-01-01 9:40:00"), user: users(:amy), club: clubs(:rattle_snake_pit))
		end
	end

	test "only one user can book a given time slot" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: bookings(:amy_christmas).time, user_id: users(:ben).id)
		end
	end

	test "a booking must have a club" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: DateTime.parse("2015-01-02 9:00:00"), user: users(:amy))
		end
	end

end