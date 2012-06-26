module Sms
	class MessageTemplate < ActiveRecord::Base
		# attributes
		attr_accessible(:system, :name, :desc, :body)

		# validations
		validates(:name, :allow_nil => true, :length => {:in => 2..64}, :format => /^[\w_]*$/)
		validates(:desc, :presence => true, :length => {:in => 2..64}, :format => /^[\w -]*$/)
		validates(:body, :presence => true, :length => {:maximum => 200})

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
