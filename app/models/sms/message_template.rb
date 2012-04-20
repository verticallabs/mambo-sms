module Sms
	class MessageTemplate
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:name, String, {:unique => true, :length => 64})
		property(:desc, String, {:required => true, :unique => true, :length => 64})
		property(:body, String, {:required => true, :length => 160})
		property(:type, Enum[:user, :system], {:required => true, :default => :user})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:name, :within => 2..32, :allow_nil => true)
		validates_format_of(:name, :with => /^[\w_]*$/, :allow_nil => true)

		validates_length_of(:desc, :within => 2..32)
		validates_format_of(:desc, :with => /^[\w ]*$/)

		#
		def self.user
			all(:type => :user)
		end

		#
		def self.system
			all(:type => :system)
		end

		def self.get_by_name(name)
			first(:name => name.to_s)
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
