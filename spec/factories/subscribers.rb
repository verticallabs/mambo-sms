FactoryGirl.define do
	#
  factory(:subscriber, :class => Sms::Subscriber) do
    phone_number  { Support::Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    active        { Support::Randomizer.boolean }
  end
end
