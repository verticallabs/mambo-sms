require 'factory_girl'

FactoryGirl.define do
  factory(:message, :class => Sms::Message) do
    status        { Randomizer.enum(Sms::STATUSES) }
    phone_number  { Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    body          { Randomizer.string(Sms::MESSAGE_LENGTH) }
    sid           { Randomizer.string(Sms::SID_LENGTH) }
    created_at    { Time.now}
    updated_at    { Time.now }
  end

  factory(:subscriber, :class => Sms::Subscriber) do
    phone_number  { Randomizer.integer(Sms::PHONE_NUMBER_LENGTH) }
    active        { Randomizer.boolean }
    created_at    { Time.now }
    updated_at    { Time.now }
  end

  factory(:message_template, :class => Sms::MessageTemplate) do
    name          { Randomizer.string(Sms::TEMPLATE_NAME_LENGTH) }
    desc          { Randomizer.string(Sms::TEMPLATE_DESC_LENGTH) }
    body          { Randomizer.string(Sms::MESSAGE_LENGTH) }
		type          { Randomizer.enum(Sms::MESSAGE_TEMPLATE_TYPES) }
    created_at    { Time.now }
    updated_at    { Time.now }
  end
end
