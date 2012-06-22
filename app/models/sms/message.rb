require "enumerize"

module Sms
	class Message < ActiveRecord::Base
		include ::Enumerize

		# attributes
		attr_accessible(:status, :phone_number, :body, :sid)
		enumerize(:status, :in => STATUSES)

		# properties
		#property(:id, Serial)
		#property(:status, Enum[*STATUSES], {:index => true, :required => true})
		#property(:phone_number, String, {:index => true, :required => true, :length => PHONE_NUMBER_LENGTH})
		#property(:body, String, :length => MESSAGE_LENGTH)
		#property(:sid, String, {:index => true, :length => SID_LENGTH})
		#property(:created_at, DateTime)
		#property(:updated_at, DateTime)

		# validations
		validates(:phone_number, {:presence => true, :length => {:is => PHONE_NUMBER_LENGTH}, :format => /^\d*$/})
		validates(:body, :length => {:maximum => MESSAGE_LENGTH})

		# associations
		belongs_to(:subscriber)
		belongs_to(:parent, {:class_name => "Message", :dependent => :destroy})
		has_many(:children, {:class_name => "Message", :foreign_key => :parent_id, :dependent => :destroy})

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
