#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

FactoryGirl.define do
	#
  factory(:user, :class => Authentication::User) do
    name          { Support::Randomizer.string(5) }
    email_address { "#{Support::Randomizer.string(5)}@#{Support::Randomizer.string(5)}.com" }
    password_digest {  Support::Randomizer.password(5) }
  end
end
