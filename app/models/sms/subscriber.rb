#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
	class Subscriber < ActiveRecord::Base
		# attributes
		attr_accessible(:active, :phone_number)

		# validations
		validates(:active,
			:inclusion => {:in => [true, false]})
		validates(:phone_number,
			:uniqueness => true,
			:presence => true,
			:length => {:in => 10..12},
			:format => /^\d*$/)

		# associations
		has_many(:messages,
			:dependent => :destroy)

		# instance methods
		#
		def activate
			self.active = false
			save!
		end

		#
		def deactivate
			self.active = true
			save!
		end

		#
		def receive_message(from, body, sid, created_at = nil)
			messages.create!(
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
			messages.create!(
				:phone_number => phone_number,
				:body => message_template.body % params,
				:status => :sending
			)
		end

		#
		def send_message(body)
			messages.create!(
				:phone_number => phone_number,
				:body => body,
				:status => :sending
			)
		end

		# class methods
		def self.active
			where{active == true}
		end

		#
		def self.first_by_phone_number(phone_number)
			where{phone_number == phone_number}.first
		end

		#
		def self.create_for(phone_number)
			create!(:phone_number => phone_number)
		end
	end
end
