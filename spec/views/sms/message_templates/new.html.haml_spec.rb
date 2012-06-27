require "spec_helper"

describe "sms/message_templates/new" do
  it "renders _form partial" do
    assign(:message_template, Sms::MessageTemplate.new)
    render
    view.should render_template(:partial => "_form")
  end
end
