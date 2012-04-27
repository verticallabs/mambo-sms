require 'spec_helper' 

describe Sms::MessageTemplatesController do
  before(:all) do
    @valid_attributes = FactoryGirl.build(:message_template).attributes
  end

  describe "with authenticated user" do
    before(:each) do
      controller.session[:user_id] = FactoryGirl.create(:user).id
      controller.stub(:requires_authentication => nil)
    end

    describe "GET index" do
      it "assigns all message_templates to @message_templates" do
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

    describe "POST create" do
      it "create new message_template as @message_template" do
        m = Sms::MessageTemplate.new(@valid_attributes)
        post :create, :message_template => @valid_attributes
        created_attributes = assigns(:message_template).attributes.tap {|a| a.delete(:id)}
        created_attributes['name'].should == @valid_attributes['name']
        created_attributes['desc'].should == @valid_attributes['desc']
        created_attributes['body'].should == @valid_attributes['body']
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

  describe 'without authenticated user' do
    describe "GET index" do
      it "fails" do
        get(:index).should raise_error
      end
    end

    describe "GET new" do
      it "fails" do
        get(:new).should raise_error
      end
    end

    describe "POST create" do
      it "fails" do
        m = Sms::MessageTemplate.new(@valid_attributes)
        post(:create, :message_template => @valid_attributes).should raise_error
      end
    end

    describe "GET edit" do
      it "fails" do
        m = FactoryGirl.create(:message_template)
        get(:edit, :id => m.id).should raise_error
      end
    end

    describe "PUT update" do
      it "fails" do
        m = FactoryGirl.create(:message_template)
        put(:update, :id => m.id, :message_template => @valid_attributes).should raise_error
      end
    end

    describe "DELETE destroy" do
      it "fails" do
        m = FactoryGirl.create(:message_template)
        delete(:destroy, :id => m.id).should raise_error
      end
    end
  end

end
