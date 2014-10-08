require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "user email cannot be blank" do
		assert_difference('User.count', 0) do
			User.create(password: 'secret123')
		end
	end

	test "user password cannot be blank" do
		assert_difference('User.count', 0) do
			User.create(email: "zoe@coupgon.com")
		end
	end

	test "the same email can only be used once" do
		assert_difference('User.count', 0) do
			User.create(email: users(:amy).email, password: "secret456")
		end
	end

	test "can create new user" do
		assert_difference('User.count') do
			User.create(email: "zoe@coupgon.com", password: "secret123")
		end
	end
end
