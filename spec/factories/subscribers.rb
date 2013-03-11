#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

FactoryGirl.define do
  #
  factory(:subscriber, :class => Sms::Subscriber) do
    phone_number  { Support::Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    active        { Support::Randomizer.boolean }
  end
end
