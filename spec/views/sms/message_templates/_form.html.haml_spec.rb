require 'spec_helper'

describe "sms/message_templates/_form" do
  it "renders form partial properly" do
    m = FactoryGirl.create(:message_template)
    assign(:message_template, m)
    render
    puts rendered.native
    rendered.should have_field('message_template_desc', :with => m.desc)
    rendered.should have_field('message_template_body', :text => m.body)
    rendered.should have_field('', :type => 'submit')
  end
end
