FactoryGirl.define do
	#
  factory(:message, :class => Sms::Message) do
    status        { Support::Randomizer.array(Sms::MESSAGE_STATUSES) }
    phone_number  { Support::Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    body          { Support::Randomizer.string(Sms::MESSAGE_BODY_MAX) }
    sid           { Support::Randomizer.string(Sms::MESSAGE_SID_LENGTH) }
  end
end