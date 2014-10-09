require 'test_helper'

class BookingTest < ActiveSupport::TestCase

	setup :set_amy
	setup :set_ben
	setup :set_grassy_acres
	setup :set_soggy_marshes
	setup :set_amy_christmas_booking

	test "a booking must have a time" do
		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, club: @grassy_acres)
		end
	end

	test "a booking must have a user" do
		assert_difference('Booking.count', 0) do
			Booking.create(time: "2015-01-01 17:00:00", club: @grassy_acres)
		end
	end

	test "a booking must have a club" do
		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2015-01-01 17:00:00")
		end
	end

	test "a booking cannot be for before 9:00 am" do
		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2014-12-01 08:00:00", club: @grassy_acres)
		end
	end

	test "a booking cannot be for after 5:00 pm" do
		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2014-12-01 17:00:01", club: @grassy_acres)
		end

		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2014-12-01 17:20:00", club: @grassy_acres)
		end

		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2014-12-01 18:00:00", club: @grassy_acres)
		end
	end

	test "a booking must be at 0, 20 or 40 minutes of the hour" do
		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2015-01-01 9:00:01", club: @grassy_acres)
		end

		assert_difference('Booking.count', 0) do
			Booking.create(user: @amy, time: "2015-01-01 9:01:01", club: @grassy_acres)
		end
	end

	test "a valid booking can be made" do
		assert_difference('Booking.count', 1) do
			Booking.create(user: @amy, time: "2015-01-01 9:40:00", club: @grassy_acres)
		end
	end

	test "only one user can book a given time slot" do
		assert_difference('Booking.count', 0) do
			Booking.create(user: @ben, time: @amy_christmas_booking.time)
		end
	end

	test "a user can only have two concurrent bookings" do
		assert_difference('Booking.count', 1) do
			Booking.create(user: @amy, time: @amy_christmas_booking.time, club: @grassy_acres)
			Booking.create(user: @amy, time: @amy_christmas_booking.time, club: @soggy_marshes)
		end
	end

	# see config/environments/test.rb for time configuration
	test "a booking can't be cancelled if it starts less than an hour from the current time" do
		assert_difference('Booking.count', 0) do
			Booking.destroy(@amy_christmas_booking)
		end
	end

end