require 'spec_helper' 

describe Sms::MessagesController do
  before(:all) do
    @valid_attributes = FactoryGirl.build(:message).attributes
  end

  describe "with authenticated user" do
    before(:each) do
      controller.session[:user_id] = FactoryGirl.create(:user).id
      controller.stub(:requires_authentication => nil)
    end

    describe "GET index" do
      it "assigns all messages to @messages" do
        m = FactoryGirl.create(:message)
        get :index
        assigns(:messages).should eq([m])
      end
    end

    describe "GET show" do
      it "shows message" do
        m = FactoryGirl.create(:message)
        get :show, :id => m.id
        assigns(:message).should eq(m)
      end
    end
  end

  describe 'without authenticated user' do
    describe "GET index" do
      it "fails" do
        get(:index).should raise_error
      end
    end

    describe "GET show" do
      it "fails" do
        m = FactoryGirl.create(:message)
        get(:show, :id => m.id).should raise_error
      end
    end
  end
end
