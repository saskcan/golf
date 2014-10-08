class Club < ActiveRecord::Base

	validates :name, presence: true, uniqueness: true

	has_many :bookings

	def get_name
		name
	end

	def self.get_for_select
		all
	end

end
