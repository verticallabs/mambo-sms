FactoryGirl.define do
	#
  factory(:message, :class => Sms::Message) do
    status        { Support::Randomizer.array(Sms::STATUSES) }
    phone_number  { Support::Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    body          { Support::Randomizer.string(Sms::MESSAGE_LENGTH) }
    sid           { Support::Randomizer.string(Sms::SID_LENGTH) }
  end
end