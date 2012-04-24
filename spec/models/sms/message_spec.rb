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
    m = Sms::Message.new(@valid_attributes.merge(:body => Randomizer.string(Sms::MESSAGE_LENGTH + 1)))

    m.should_not be_valid
  end

  it 'is invalid with phone number too long' do
    m = Sms::Message.new(@valid_attributes.merge(:phone_number => Randomizer.integer(Sms::PHONE_NUMBER_LENGTH + 1)))

    m.should_not be_valid
  end

  it 'is invalid with phone number too short' do
    m = Sms::Message.new(@valid_attributes.merge(:phone_number => Randomizer.integer(Sms::PHONE_NUMBER_LENGTH - 1)))

    m.should_not be_valid
  end

  it 'should create without Subscriber if unknown phone number' do
    phone_number = @valid_attributes[:phone_number]
    body = @valid_attributes[:body]
    sid = @valid_attributes[:sid]

    m = Sms::Message.receive_from_phone_number(phone_number, body, sid)

    m.should be_valid
    m.subscriber.should be_nil
    m.status.should == :Received
  end

  it 'should create with Subscriber if known phone number' do
    subscriber = FactoryGirl.create(:subscriber)
    phone_number = subscriber.phone_number
    body = @valid_attributes[:body]
    sid = @valid_attributes[:sid]

    m = Sms::Message.receive_from_phone_number(phone_number, body, sid)

    m.should be_valid
    m.subscriber.should == subscriber
    m.status.should == :Received
  end

  it 'should be able to be updated by id' do
    m = FactoryGirl.create(:message)
    new_status = Sms::STATUSES.reject{|s| s == m.status}.first
    new_sid = 'test'

    Sms::Message.update_status_by_id(m.id, new_status, new_sid)
    m.reload

    m.status.should == new_status
    m.sid.should == new_sid
  end

  it 'should create a message to send to phone number properly' do
    body = 'test'
    m = Sms::Message.create_to_phone_number(@valid_attributes[:phone_number], body)

    m.persisted?.should be_true
    m.body.should == body
    m.status.should == :Sending
  end

  it 'should create a message to send to subscriber properly' do
    body = 'test'
    subscriber = FactoryGirl.create(:subscriber)
    m = Sms::Message.create_to_subscriber(subscriber, body)

    m.phone_number.should == subscriber.phone_number
    m.body.should == body
    m.status.should == :Sending
    m.persisted?.should be_true
  end

  it 'should create replies properly' do
    m = Sms::Message.create(@valid_attributes.merge(:status => :Received))

    r = Sms::Message.create_reply(m, 'reply')
    m.reload

    r.parent.should == m
    r.status.should == :Sending
    r.persisted?.should be_true
    m.children.include?(r).should be_true
  end
end
