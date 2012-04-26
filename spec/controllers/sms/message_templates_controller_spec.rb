require 'spec_helper' 

describe Sms::MessageTemplatesController do
  before(:all) do
    @valid_attributes = FactoryGirl.build(:message_template).attributes
  end

  before(:each) do
    controller.session[:user_id] = FactoryGirl.create(:user).id
    controller.stub(:requires_authentication => nil)
  end

  describe "GET index" do
    it "assigns all messages to @messages" do
      m = FactoryGirl.create(:message_template)
      get :index
      assigns(:message_templates).should eq([m])
    end
  end

  describe "GET new" do
    it "assigns a new message_template to @message_template" do
      m = Sms::MessageTemplate.new
      get :new
      assigns(:message_template).should eq(m)
    end
  end

  describe "GET edit" do
    it "edits message_template" do
      m = FactoryGirl.create(:message_template)
      get :edit, :id => m.id
      assigns(:message_template).should eq(m)
    end
  end

  describe "PUT update" do
    it "updates message_template" do
      m = FactoryGirl.create(:message_template)
      put :update, :id => m.id, :message_template => @valid_attributes
      m.update(@valid_attributes)
      assigns(:message_template).should eq(m)
    end
  end

  describe "DELETE destroy" do
    it "destroys message_template" do
      m = FactoryGirl.create(:message_template)
      delete :destroy, :id => m.id
      Sms::MessageTemplate.get(m.id).should be_nil
    end
  end
end
