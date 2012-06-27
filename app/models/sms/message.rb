module Sms
	class Message < ActiveRecord::Base
		# attributes
		attr_accessible(:status, :phone_number, :body, :sid)
		enum_attr(:status, MESSAGE_STATUSES, :init => :unknown, :nil => false)

		# validations
		validates(:phone_number, {:presence => true, :length => {:is => PHONE_NUMBER_LENGTH}, :format => /^\d*$/})
		validates(:body, :length => {:maximum => MESSAGE_BODY_MAX})

		# associations
		belongs_to(:subscriber)
		belongs_to(:parent, {:class_name => "Message", :dependent => :destroy})
		has_many(:children, {:class_name => "Message", :foreign_key => :parent_id, :dependent => :destroy})

		# class methods
		#
		def self.sent
			where(:status => :sent)
		end

		#
		def self.received
			where(:status => :received)
		end

		#
		def self.read
			where(:status => :read)
		end

		#
		def self.received_or_read
			where(:status => [:received, :read])
		end

		#
		def self.sorted_by(key, order)
			order("#{key} #{order.to_s.upcase}")
		end

		#
		def self.first_by_sid(sid)
			where(:sid => sid).first
		end

		# receive a message
		def self.receive_from_phone_number(phone_number, body, sid, date = nil)
			subscriber = Subscriber.first_by_phone_number(phone_number)

			if subscriber.nil?
				create_from_phone_number(phone_number, body, sid, date)
			else
				create_from_subscriber(subscriber, body, sid, date)
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
			reply.status = :sending
			reply.save
			reply
		end

		#
		def self.create_to_phone_number(phone_number, body)
			message = Message.new
			message.phone_number = phone_number
			message.body = body
			message.status = :sending
			message.save
			message
		end

		# create message from phone number
		def self.create_from_phone_number(phone_number, body, sid, date)
			message = Message.new
			message.phone_number = phone_number
			message.body = body
			message.status = :received
			message.sid = sid
			message.created_at = date
			message.save
			message
		end

		# create message from subscriber with body and sid
		def self.create_from_subscriber(subscriber, body, sid, date)
			message = subscriber.messages.new
			message.phone_number = subscriber.phone_number
			message.body = body
			message.status = :received
			message.sid = sid
			message.created_at = date
			message.save
			message
		end
	end
end
