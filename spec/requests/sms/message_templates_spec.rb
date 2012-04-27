require 'spec_helper'

describe "Message Templates" do
  describe "as authenticated user" do
    before(:each) do
      password = 'password'
      u = Authentication::User.create_by(FactoryGirl.attributes_for(:user).merge(:password => password, :password_confirmation => password))
      page.driver.post(sessions_path, :credentials => {:email_address => u.email_address, :password => password}) 
      @t = FactoryGirl.create(:message_template)
    end

    describe "GET /sms/message_templates" do
      it "displays message_templates" do
        visit message_templates_path
        response.code.should be(200)
      end
    end
  end
end
