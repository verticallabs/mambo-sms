#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe Sms::Message do
	#
	describe "validations" do
		subject { create(:message) }
		it { should validate_presence_of(:phone_number) }
		it { should ensure_length_of(:body).is_at_most(160) }
	end

	#
	describe "associations" do
		subject { create(:message) }
		it { should belong_to(:subscriber) }
		it { should belong_to(:parent) }
		it { should have_many(:children) }
	end

	#
	describe "methods" do
		it "recieves reply" do
			body = "body"
			sid = "sid"
			message = create(:message_with_subscriber)
			reply = message.receive_reply(body, sid, DateTime.now)
			reply.should_not be_nil
			reply.subscriber.should == message.subscriber
			reply.phone_number.should == message.phone_number
			reply.body.should == body
			reply.sid.should == sid
		end

		it "sends reply" do
			body = "body"
			message = create(:message_with_subscriber)
			reply = message.send_reply(body)
			reply.should_not be_nil
			reply.subscriber.should == message.subscriber
			reply.phone_number.should == message.phone_number
			reply.body.should == body
		end

		#
		it "filter -> sent" do
			create(:message, :status => :sent)
			ms = Sms::Message.sent
			ms.count.should == 1
		end

		#
		it "filter -> received" do
			create(:message, :status => :received)
			ms = Sms::Message.received
			ms.count.should == 1
		end

		#
		it "filter -> read" do
			create(:message, :status => :read)
			ms = Sms::Message.read
			ms.count.should == 1
		end

		#
		it "filter -> received or read" do
			create(:message, :status => :read)
			create(:message, :status => :received)
			ms = Sms::Message.received_or_read
			ms.count.should == 2
		end

		#
		it "sorts" do
			m1 = create(:message, :body => "Z")
			m2 = create(:message, :body => "A")
			ms = Sms::Message.sorted_by(:body, :asc)
			ms.should == [m2, m1]
		end

		#
		it "first by sid" do
			sid = Support::Randomizer.string(10)
			expected = create(:message, :sid => sid)
			message = Sms::Message.first_by_sid(expected.sid)
			message.should == expected
		end
	end
end
