require 'factory_girl'

FactoryGirl.define do
  factory(:message, :class => Sms::Message) do
    status        { Sms::Message::STATUSES[Kernel.rand(Sms::Message::STATUSES.length)] }
    phone_number  { Randomizer.integer(Sms::Message::PHONE_NUMBER_LENGTH) }
    body          { Randomizer.string(Sms::Message::MESSAGE_LENGTH) }
    sid           { Randomizer.string(Sms::Message::SID_LENGTH) }
    created_at    { Time.now}
    updated_at    { Time.now }
  end
end
