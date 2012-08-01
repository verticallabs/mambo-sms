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
			update(:active => false)
		end

		#
		def enable
			update(:active => true)
		end

		#
		def receive_message(from, body, sid, created_at = nil)
			messages.create(
				:phone_number => phone_number,
				:body => body,
				:status => :received,
				:sid => sid,
				:created_at => created_at
			)
		end

		#
		def send_message_using_template(name, params = {})
			message_template = MessageTemplate.get_by_name(name)
			messages.create(
				:phone_number => phone_number,
				:body => message_template.body % params,
				:status => :sending
			)
		end

		#
		def send_message(body)
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
		def self.create_for(phone_number)
			create(:phone_number => phone_number)
		end
	end
end
