module Sms
	class Message
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:status, Enum[:Unknown, :Received, :Sending, :Sent, :Failed], :index => true)
		property(:phone_number, String, {:required => true, :index => true, :length => 10})
		property(:body, String, :length => 160)
		property(:sid, String, :length => 34)
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:phone_number, :is => 10)
		validates_format_of(:phone_number, :with => /^\d*$/)

		validates_presence_of(:body)
		validates_length_of(:body, :max => 160)

		# associations
		belongs_to(:subscriber, 'Subscriber', :required => false)
		belongs_to(:parent, 'Message', :required => false)
		has(n, :children, 'Message', :child_key => :parent_id)

		# class methods
		#
		def self.sent
			all(:status => :Sent)
		end

		# search
		def self.search(page, per_page)
			page(page, {:per_page => per_page, :order => [:updated_at.desc]})
		end

		# receive a message
		def self.receive_from_phone_number(phone_number, body, sid)
			subscriber = Subscriber.first_by_phone_number(phone_number)

			if subscriber.nil?
				new_from_phone_number(phone_number, body, sid)
			else
				new_from_subscriber(subscriber, body, sid)
			end
		end

		# update the status of a message
		def self.update_status_by_id(id, status, sid)
			message = Message.get!(id)
			message.status = status
			message.sid = sid
			message.save
			message
		end

		#
		def self.create_reply(message, body)
			reply = message.children.new
			reply.subscriber = message.subscriber
			reply.phone_number = message.phone_number
			reply.body = body
			reply.status = :Sending
			reply.save
			reply
		end

		#
		def self.create_to_subscriber(subscriber, body)
			message = subscriber.messages.new
			message.phone_number = subscriber.phone_number
			message.body = body
			message.status = :Sending
			message.save
			message
		end

		#
		def self.create_to_phone_number(phone_number, body)
			message = Message.new
			message.phone_number = phone_number
			message.body = body
			message.status = :Sending
			message.save
			message
		end

		# create message from phone number
		def self.new_from_phone_number(phone_number, body, sid)
			message = Message.new
			message.phone_number = phone_number
			message.body = body
			message.status = :Received
			message.sid = sid
			message
		end

		# create message from subscriber with body and sid
		def self.new_from_subscriber(subscriber, body, sid)
			message = subscriber.messages.new
			message.phone_number = subscriber.phone_number
			message.body = body
			message.status = :Received
			message.sid = sid
			message
		end
	end
end