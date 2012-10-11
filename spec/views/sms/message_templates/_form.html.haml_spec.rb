#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe "sms/message_templates/_form" do
  it "renders form partial properly" do
    m = create(:message_template)
    assign(:message_template, m)
    render
    rendered.should have_field("message_template_desc", :with => m.desc)
    rendered.should have_field("message_template_body", :text => m.body)
    rendered.should have_field("", :type => "submit")
  end
end
