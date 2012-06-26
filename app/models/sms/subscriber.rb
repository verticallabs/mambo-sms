module Sms
	class Subscriber < ActiveRecord::Base
		# attributes
		attr_accessible(:active, :phone_number)

		# validations
		validates(:active, :inclusion => {:in => [true, false]})
		validates(:phone_number, {:uniqueness => true, :presence => true, :length => {:is => PHONE_NUMBER_LENGTH}, :format => /^\d*$/})

		# associations
		has_many(:messages, :dependent => :destroy)

		# instance methods
		#
		def disable
			update(:active => false)
		end

		#
		def enable
			update(:active => true)
		end

		#
		def create_outgoing_message(body)
			messages.create(
				:phone_number => phone_number,
				:body => body,
				:status => :sending
			)
		end

		# class methods
		def self.active
			all(:active => true)
		end

		#
		def self.first_by_phone_number(phone_number)
			first(:phone_number => phone_number)
		end

		#
		def self.create_by_phone_number(phone_number)
			create(:phone_number => phone_number)
		end
	end
end
