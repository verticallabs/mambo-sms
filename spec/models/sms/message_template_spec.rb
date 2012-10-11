#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe Sms::MessageTemplate do
	#
	describe "validations" do
		subject { create(:message_template) }
		it { should ensure_length_of(:name).is_at_least(2) }
		it { should ensure_length_of(:name).is_at_most(64) }
		it { should validate_presence_of(:desc) }
		it { should ensure_length_of(:desc).is_at_least(2) }
		it { should ensure_length_of(:desc).is_at_most(64) }
		it { should ensure_length_of(:body).is_at_most(200) }
	end

	#
	describe "methods" do
		#
		it "filters -> user" do
			mt = create(:message_template, :system => false)
			mts = Sms::MessageTemplate.user
			mts.size.should == 1
			mts[0].should == mt
		end

		#
		it "filters -> system" do
			mt = create(:message_template, :system => true)
			mts = Sms::MessageTemplate.system
			mts.size.should == 1
			mts[0].should == mt
		end

		#
		it "sorts" do
			mt1 = create(:message_template, :name => "ZZ")
			mt2 = create(:message_template, :name => "AA")
			mts = Sms::MessageTemplate.sorted_by("name", :asc)
			mts.should == [mt2, mt1]
		end

		#
		it "gets by name" do
			name = "test"
			create(:message_template, :name => name)
			mt = Sms::MessageTemplate.get_by_name(name)
			mt.should_not be_nil
		end
	end
end
