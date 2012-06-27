FactoryGirl.define do
	#
  factory(:message_template, :class => Sms::MessageTemplate) do
    name          { Support::Randomizer.string(Sms::MESSAGE_TEMPLATE_NAME_MAX) }
    desc          { Support::Randomizer.string(Sms::MESSAGE_TEMPLATE_DESC_MAX) }
    body          { Support::Randomizer.string(Sms::MESSAGE_TEMPLATE_BODY_MAX) }
		system        { Support::Randomizer.boolean }
  end
end