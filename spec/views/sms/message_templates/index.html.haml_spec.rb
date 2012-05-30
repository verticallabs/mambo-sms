require 'spec_helper'

describe "sms/message_templates/index" do
  it "renders _table partial for message templates" do
    2.times { FactoryGirl.create(:message_template) }

    assign(:message_templates, Sms::MessageTemplate.all.page(:per_page => 3))
    render
    view.should render_template(:partial => "_table")
  end
end
