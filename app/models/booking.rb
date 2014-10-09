class Booking < ActiveRecord::Base

	validates :time, presence: true
	validates_uniqueness_of :time, scope: :club_id
	validates :club_id, presence: true 
	validates :user_id, presence: true

	#custom validations
	validate :time_cannot_be_before_9_am
	validate :time_cannot_be_after_5_pm
	validate :time_must_be_at_0_20_or_40_minutes
	validate :a_user_can_have_up_to_2_concurrent_bookings
	before_destroy :bookings_within_1_hour_cannot_be_deleted

	belongs_to :user
	belongs_to :club

	def email
		user.get_email()
	end

	def club_name
		club.get_name()
	end

	def formatted_time
		time.to_formatted_s(:long)
	end

	private

	def self.count_existing_bookings(user_id, time)
		self.where(user_id: user_id, time: time).count
	end

	# validations
	def time_cannot_be_before_9_am
		if time.present?
			if time.hour < 9
				errors.add(:time, "can't be before 9:00am")
			end
		end
	end

	def time_cannot_be_after_5_pm
		if time.present?
			if (time - 1.second).hour > 16
				errors.add(:time, "can't be after 5:00pm")
			end
		end
	end

	def time_must_be_at_0_20_or_40_minutes
		if time.present?
			if time.sec == 0
				if time.min % 20 == 0
					return
				end
			end
			errors.add(:time, "must be booked at 0, 20 or 40 minutes")
		end
	end

	def a_user_can_have_up_to_2_concurrent_bookings
		if Booking.count_existing_bookings(user_id, time) > 1
			errors.add(:time, "You already have two reservations at this time")
		end
	end

	def bookings_within_1_hour_cannot_be_deleted
		if hours_from_now(time) < 1
			return false
		end
	end

	def hours_from_now(dateTime)
		(dateTime - Time.zone.now) / (60 * 60)
	end

end
