require "spec_helper"

describe Sms::Subscriber do
	#
	describe "validations" do
		subject { create(:subscriber) }
		it { should validate_presence_of(:phone_number) }
		it { should validate_uniqueness_of(:phone_number) }
		#it { should ensure_length_of(:phone_number).is_equal_to(Sms::PHONE_NUMBER_LENGTH) }
	end

	#
	describe "associations" do
		subject { create(:subscriber) }
		it { should have_many(:messages).dependent(:destroy) }
	end

	describe "methods" do
		#
		it 'should create an outgoing message properly' do
			body = 'test'
			subscriber = create(:subscriber)
			m = subscriber.create_outgoing_message(body)

			m.phone_number.should == subscriber.phone_number
			m.body.should == body
			m.status.should == :sending
			m.persisted?.should be_true
		end
  end
end
