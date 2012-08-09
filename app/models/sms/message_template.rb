#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
	class MessageTemplate < ActiveRecord::Base
		# attributes
		attr_accessible(:system, :name, :desc, :body)

		# validations
		validates(:name, :allow_nil => true, :length => {:in => MESSAGE_TEMPLATE_NAME_MIN..MESSAGE_TEMPLATE_NAME_MAX}, :format => /^[\w_]*$/)
		validates(:desc, :presence => true, :length => {:in => MESSAGE_TEMPLATE_DESC_MIN..MESSAGE_TEMPLATE_DESC_MAX}, :format => /^[\w -]*$/)
		validates(:body, :presence => true, :length => {:maximum => MESSAGE_TEMPLATE_BODY_MAX})

		#
		def self.user
			where(:system => false)
		end

		#
		def self.system
			where(:system => true)
		end

		#
		def self.sorted_by(key, order)
			order("#{key} #{order.to_s.upcase}")
		end

		#
		def self.get_by_name(name)
			where(:name => name.to_s).first || raise("#{name} not_found")
		end

		#
		def self.create_by(params)
			create(params)
		end

		#
		def self.update_by_id(id, params)
			update(id, params)
		end

		#
		def self.destroy_by_id(id)
			message_template = find(id)
			message_template.destroy
			message_template
		end
	end
end
