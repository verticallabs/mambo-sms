module Sms
	class MessageTemplate < ActiveRecord::Base
		# attributes
		attr_accessible(:system, :name, :desc, :body)

		# properties
		#property(:id, Serial)
		#property(:system, Boolean, {:required => true, :default => false})
		#property(:name, String, {:unique => true, :length => TEMPLATE_NAME_LENGTH})
		#property(:desc, String, {:required => true, :unique => true, :length => TEMPLATE_DESC_LENGTH})
		#property(:body, String, {:required => true, :length => MESSAGE_TEMPLATE_LENGTH})
		#property(:created_at, DateTime)
		#property(:updated_at, DateTime)

		# validations
		validates_length_of(:name, :within => 2..TEMPLATE_NAME_LENGTH, :allow_nil => true)
		validates_format_of(:name, :with => /^[\w_]*$/, :allow_nil => true)

		validates_length_of(:desc, :within => 2..TEMPLATE_DESC_LENGTH)
		validates_format_of(:desc, :with => /^[\w -]*$/)

		#
		def self.user
			all(:system => false)
		end

		#
		def self.system
			all(:system => true)
		end

		#
		def self.sorted_by(key, order)
			all(:order => [key.send(order)])
		end

		#
		def self.get_by_name(name)
			first(:name => name.to_s) || raise("#{name} not_found")
		end

		#
		def self.create_by(params)
			create(params)
		end

		#
		def self.update_by_id(id, params)
			message_template = get!(id)
			message_template.attributes = params
			message_template.save
			message_template
		end

		#
		def self.destroy_by_id(id)
			message_template = get!(id)
			message_template.destroy
			message_template
		end
	end
end
