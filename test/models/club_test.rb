require 'test_helper'

class ClubTest < ActiveSupport::TestCase
	
	test "a club must have a name" do
		assert_difference('Club.count', 0) do
			Club.create()
		end
	end

	test "a club must have a unique name" do
		assert_difference('Club.count', 0) do
			Club.create(name: clubs(:grassy_acres).name)
		end
	end

end
