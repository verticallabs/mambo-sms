#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe "sms/message_templates/index" do
  it "renders _table partial for message templates" do
    3.times { create(:message_template) }
    assign(:message_templates, Sms::MessageTemplate.paginate(:page=> 1, :per_page => 3))
    render
    view.should render_template(:partial => "_table")
  end
end
