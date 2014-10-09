ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all


  def login_as_amy
  	sign_in(users(:amy))
  end

  def set_amy
    @amy = users(:amy)
  end

  def set_ben
    @ben = users(:ben)
  end

  def set_grassy_acres
    @grassy_acres = clubs(:grassy_acres)
  end

  def set_soggy_marshes
    @soggy_marshes = clubs(:soggy_marshes)
  end

  def set_amy_christmas_booking
    @amy_christmas_booking = bookings(:amy_christmas)
  end

end

class ActionController::TestCase
	include Devise::TestHelpers
end