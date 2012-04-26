require 'factory_girl'
require 'mambo/support/randomizer'

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

  factory(:user, :class => Authentication::User) do
    name          { Randomizer.string(Sms::TEMPLATE_NAME_LENGTH) }
    email_address { "#{Randomizer.string(5)}@#{Randomizer.string(5)}.com" }
    password_digest {  Randomizer.password(5) }
    created_at    { Time.now }
    updated_at    { Time.now }
  end
end
