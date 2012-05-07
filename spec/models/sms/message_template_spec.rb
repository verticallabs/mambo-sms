require 'spec_helper'

describe Sms::MessageTemplate do
  before(:all) do
    @valid_attributes = FactoryGirl.build(:message_template).attributes
  end

  it 'is invalid when new' do
    m = Sms::MessageTemplate.new

    m.should_not be_valid
  end

  it 'is valid with valid params' do
    m = Sms::MessageTemplate.new(@valid_attributes)

    m.should be_valid
  end

  it 'is invalid with body too long' do
    m = Sms::MessageTemplate.new(@valid_attributes.merge(:body => Randomizer.string(Sms::MESSAGE_TEMPLATE_LENGTH + 1)))

    m.should_not be_valid
  end

  it 'is invalid with name too long' do
    m = Sms::MessageTemplate.new(@valid_attributes.merge(:name => Randomizer.string(Sms::TEMPLATE_NAME_LENGTH + 1)))

    m.should_not be_valid
  end

  it 'is invalid with description too long' do
    m = Sms::MessageTemplate.new(@valid_attributes.merge(:desc => Randomizer.string(Sms::TEMPLATE_DESC_LENGTH + 1)))

    m.should_not be_valid
  end

  it 'should be able to be updated by id' do
    m = FactoryGirl.create(:message_template)
    new_params = { :name => 'new_name', :desc => 'new desc', :body => 'new body' }

    Sms::MessageTemplate.update_by_id(m.id, new_params)
    m.reload

    m.name.should == new_params[:name]
    m.desc.should == new_params[:desc]
    m.body.should == new_params[:body]
  end

  it 'should be able to be destroy by id' do
    m = FactoryGirl.create(:message_template)

    Sms::MessageTemplate.destroy_by_id(m.id)
    id = m.id

    Sms::MessageTemplate.get(id).should be_nil
  end
end
