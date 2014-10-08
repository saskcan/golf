class Booking < ActiveRecord::Base

	validates :time, presence: true, uniqueness: true
	validates :user_id, presence: true
	validate :time_cannot_be_before_9_am
	validate :time_cannot_be_after_5_pm
	validate :time_must_be_at_0_20_or_40_minutes

	belongs_to :user
	belongs_to :club

	def email
		user.get_email()
	end

	def formatted_time
		time.to_formatted_s(:long)
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

end
