require "rails"
require "dm-rails"
require "dm-types"
require "dm-validations"
require "dm-migrations"
require "dm-constraints"
require "dm-transactions"
require "dm-timestamps"
require "will_paginate"
require "haml-rails"
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
	MESSAGE_TEMPLATE_LENGTH = 200
end
