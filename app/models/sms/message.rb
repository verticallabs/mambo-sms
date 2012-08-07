module Sms
	class Message < ActiveRecord::Base
		# attributes
		attr_accessible(:subscriber_id, :status, :phone_number, :body, :sid, :created_at)
		enum_attr(:status, MESSAGE_STATUSES, :init => :unknown, :nil => false)

		# validations
		validates(:phone_number, {:presence => true, :length => {:is => PHONE_NUMBER_LENGTH}, :format => /^\d*$/})
		validates(:body, :length => {:maximum => MESSAGE_BODY_MAX})

		# associations
		belongs_to(:subscriber)
		belongs_to(:parent, {:class_name => "Message", :dependent => :destroy})
		has_many(:children, {:class_name => "Message", :foreign_key => :parent_id, :dependent => :destroy})

		# instance methods

		#
		def receive_reply(body, sid, created_at = nil)
			children.create(
				:subscriber_id => subscriber_id,
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
				:subscriber_id => subscriber_id,
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
