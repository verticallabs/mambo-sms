#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

FactoryGirl.define do
	#
  factory(:message_template, :class => Sms::MessageTemplate) do
    name          { Support::Randomizer.string(Sms::MESSAGE_TEMPLATE_NAME_MAX) }
    desc          { Support::Randomizer.string(Sms::MESSAGE_TEMPLATE_DESC_MAX) }
    body          { Support::Randomizer.string(Sms::MESSAGE_TEMPLATE_BODY_MAX) }
		system        { Support::Randomizer.boolean }
  end
end
