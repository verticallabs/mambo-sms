#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "rails/all"
require "enumerated_attribute"
require "will_paginate"
require "haml-rails"
require "squeel"
require "mambo-support"
require "mambo-authentication"

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

require "sms/version"
require "sms/engine"
