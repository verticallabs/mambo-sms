#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Sms
	class MessageTemplate < ActiveRecord::Base
		# attributes
		attr_accessible(:system, :name, :desc, :body)

		# validations
		validates(:name,
			:allow_nil => true,
			:length => {:in => 2..64},
			:format => /^[\w_]*$/)
		validates(:desc,
			:presence => true,
			:length => {:in => 2..64},
			:format => /^[\w -]*$/)
		validates(:body,
			:presence => true,
			:length => {:maximum => 200})

		# class methods
		#
		def self.user
			where{system == false}
		end

		#
		def self.system
			where{system == true}
		end

		#
		def self.get_by_name(value)
			where{name == value.to_s}.first || raise("#{value} not_found")
		end
	end
end
