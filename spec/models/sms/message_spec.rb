require 'spec_helper'

describe Sms::Message do
  before(:all) do
    @valid_attributes = FactoryGirl.build(:message).attributes
  end

  it 'is invalid when new' do
    m = Sms::Message.new
    m.should_not be_valid
  end

  it 'is valid with valid params' do
    m = Sms::Message.new(@valid_attributes)
    m.should be_valid
  end

  it 'is invalid with body too long' do
    m = Sms::Message.new(@valid_attributes.merge(:body => Randomizer.string(Sms::Message::MESSAGE_LENGTH + 1)))
    m.should_not be_valid
  end

  it 'is invalid with phone number too long' do
    m = Sms::Message.new(@valid_attributes.merge(:phone_number => 12345678901))
    m.should_not be_valid
  end

  it 'is invalid with phone number too short' do
    m = Sms::Message.new(@valid_attributes.merge(:phone_number => 123456780))
    m.should_not be_valid
  end
end
