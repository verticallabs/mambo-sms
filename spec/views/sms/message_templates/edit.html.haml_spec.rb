#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe "sms/message_templates/edit" do
  it "renders _form partial" do
    assign(:message_template, Sms::MessageTemplate.new)
    render
    view.should render_template(:partial => "_form")
  end
end
