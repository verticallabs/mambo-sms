require "rails/all"
require "simple_enum"
require "will_paginate"
require "haml-rails"
require "mambo-support"
require "mambo-authentication"

require "sms/version"
require "sms/engine"

module Sms
	# constants
	PHONE_NUMBER_LENGTH = 10
	STATUSES = [:unknown, :received, :sending, :sent, :failed, :read]
	MESSAGE_LENGTH = 160
	SID_LENGTH = 34
	TEMPLATE_NAME_LENGTH = 64
	TEMPLATE_DESC_LENGTH = 64
	TEMPLATE_BODY_LENGTH = 200
end
