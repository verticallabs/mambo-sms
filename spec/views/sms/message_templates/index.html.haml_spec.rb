require 'spec_helper'

describe "sms/message_templates/index" do
  it "renders _item partial for each message template" do
    2.times { FactoryGirl.create(:message_template) }

    assign(:message_templates, Sms::MessageTemplate.all.page(:per_page => 3))
    render
    view.should render_template(:partial => "_item", :count => 2)
  end

  it "renders _item partial for each message template on the page" do
    2.times { FactoryGirl.create(:message_template) }

    assign(:message_templates, Sms::MessageTemplate.all.page(:per_page => 1))
    render
    view.should render_template(:partial => "_item", :count => 1)
  end
end
