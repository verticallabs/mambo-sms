FactoryGirl.define do
	#
  factory(:user, :class => Authentication::User) do
    name          { Support::Randomizer.string(Sms::TEMPLATE_NAME_LENGTH) }
    email_address { "#{Support::Randomizer.string(5)}@#{Support::Randomizer.string(5)}.com" }
    password_digest {  Support::Randomizer.password(5) }
  end
end
