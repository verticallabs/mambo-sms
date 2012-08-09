#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

FactoryGirl.define do
	#
  factory(:message, :class => Sms::Message) do
    status        { Support::Randomizer.array(Sms::MESSAGE_STATUSES) }
    phone_number  { Support::Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    body          { Support::Randomizer.string(Sms::MESSAGE_BODY_MAX) }
    sid           { Support::Randomizer.string(Sms::MESSAGE_SID_LENGTH) }

    factory(:message_with_subscriber) do
    	subscriber
    end
  end
end