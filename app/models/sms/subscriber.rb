module Sms
	class Subscriber
		include DataMapper::Resource

    # properties
		property(:id, Serial)
		property(:active, Boolean, {:required => true, :default => true, :index => true})
		property(:phone_number, String, {:required=> true, :unique => true, :length => PHONE_NUMBER_LENGTH})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:phone_number, :is => PHONE_NUMBER_LENGTH)
		validates_format_of(:phone_number, :with => /^\d*$/)

		# associations
		has(n, :messages, :constraint => :destroy)

		# instance methods
		#
		def disable
			active = false
			save
		end

		#
		def enable
			active = true
			save
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
