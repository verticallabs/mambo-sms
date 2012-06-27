require "spec_helper"

describe "sms/message_templates/index" do
  it "renders _table partial for message templates" do
    3.times { create(:message_template) }
    assign(:message_templates, Sms::MessageTemplate.paginate(:page=> 1, :per_page => 3))
    render
    view.should render_template(:partial => "_table")
  end
end
