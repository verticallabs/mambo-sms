FactoryGirl.define do
	#
  factory(:message_template, :class => Sms::MessageTemplate) do
    name          { Support::Randomizer.string(Sms::TEMPLATE_NAME_LENGTH) }
    desc          { Support::Randomizer.string(Sms::TEMPLATE_DESC_LENGTH) }
    body          { Support::Randomizer.string(Sms::MESSAGE_LENGTH) }
		system        { Support::Randomizer.boolean }
  end
end