module Sms
	class Message
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:status, Enum[*STATUSES], {:index => true, :required => true})
		property(:phone_number, String, {:index => true, :required => true, :length => PHONE_NUMBER_LENGTH})
		property(:body, String, :length => MESSAGE_LENGTH)
		property(:sid, String, {:index => true, :length => SID_LENGTH})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:phone_number, :is => PHONE_NUMBER_LENGTH)
		validates_format_of(:phone_number, :with => /^\d*$/)

		validates_length_of(:body, :max => MESSAGE_LENGTH)

		# associations
		belongs_to(:subscriber, Subscriber, :required => false)
		belongs_to(:parent, Message, :required => false)
		has(n, :children, Message, :child_key => :parent_id, :constraint => :destroy)

		# instance methods

		#
		def receive_reply(body, sid, created_at = nil)
			children.create(
				:subscriber => subscriber,
				:phone_number => phone_number,
				:body => body,
				:status => :received,
				:sid => sid,
				:created_at => created_at
			)
		end

		#
		def send_reply(body)
			children.create(
				:subscriber => subscriber,
				:phone_number => phone_number,
				:body => body,
				:status => :sending
			)
		end

		#
		def save_status(status, sid)
			self.status = status
			self.sid = sid
			save
		end

		# class methods
		#
		def self.sent
			all(:status => :sent)
		end

		#
		def self.received
			all(:status => :received)
		end

		#
		def self.read
			all(:status => :read)
		end

		#
		def self.received_or_read
			received | read
		end

		#
		def self.sorted_by(key, order)
			all(:order => [key.send(order)])
		end

		#
		def self.first_by_sid(sid)
			first(:sid => sid)
		end

		#
		def self.send_message(phone_number, body)
			create(
				:phone_number => phone_number,
				:body => body,
				:status => :sending
			)
		end

		#
		def self.receive_message(phone_number, body, sid, created_at = nil)
			create(
				:phone_number => phone_number,
				:body => body,
				:status => :received,
				:sid => sid,
				:created_at => created_at
			)
		end
	end
end
