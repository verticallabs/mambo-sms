require 'spec_helper'

describe Sms::Subscriber do
  before(:all) do
    @valid_attributes = FactoryGirl.build(:subscriber).attributes
  end

  it 'is invalid when new' do
    s = Sms::Subscriber.new

    s.should_not be_valid
  end

  it 'is valid with valid params' do
    s = Sms::Subscriber.new(@valid_attributes)

    s.should be_valid
  end

  it 'is invalid with phone number too long' do
    s = Sms::Subscriber.new(@valid_attributes.merge(:phone_number => Randomizer.integer(Sms::PHONE_NUMBER_LENGTH + 1)))

    s.should_not be_valid
  end

  it 'is invalid with phone number too short' do
    s = Sms::Subscriber.new(@valid_attributes.merge(:phone_number => Randomizer.integer(Sms::PHONE_NUMBER_LENGTH - 1)))

    s.should_not be_valid
  end

  it 'destroys messages when destroyed' do
    s = FactoryGirl.create(:subscriber)
    m = FactoryGirl.create(:message)
    s.messages << m
    m.save

    m.subscriber.should == s

    id = m.id
    s.destroy

    Sms::Message.get(id).should be_nil
  end

  it 'should create an outgoing message properly' do
    body = 'test'
    subscriber = FactoryGirl.create(:subscriber)
    m = subscriber.create_outgoing_message(body)

    m.phone_number.should == subscriber.phone_number
    m.body.should == body
    m.status.should == :sending
    m.persisted?.should be_true
  end
end
