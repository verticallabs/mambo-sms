require "rails/all"
require "enumerated_attribute"
require "will_paginate"
require "haml-rails"
require "mambo-support"
require "mambo-authentication"

require "sms/version"
require "sms/engine"

module Sms
	# constants
	PHONE_NUMBER_LENGTH = 10
	MESSAGE_STATUSES = [:unknown, :received, :sending, :sent, :failed, :read]
	MESSAGE_BODY_MAX = 160
	MESSAGE_SID_LENGTH = 34
	MESSAGE_TEMPLATE_NAME_MIN = 2
	MESSAGE_TEMPLATE_NAME_MAX = 64
	MESSAGE_TEMPLATE_DESC_MIN = 2
	MESSAGE_TEMPLATE_DESC_MAX = 64
	MESSAGE_TEMPLATE_BODY_MAX = 200
end
