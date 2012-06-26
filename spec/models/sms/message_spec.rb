require 'spec_helper'

describe Sms::Message do
	#
	describe "validations" do
		subject { create(:message) }
		it { should validate_presence_of(:phone_number) }
		it { should ensure_length_of(:body).is_at_most(Sms::MESSAGE_LENGTH) }
	end

	#
	describe "associations" do
		subject { create(:message) }
		it { should belong_to(:subscriber) }
		it { should belong_to(:parent) }
		it { should have_many(:children) }
	end
end
