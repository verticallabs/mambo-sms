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
			mts = Sms::MessageTemplate.sorted_by(:name, :asc)
			mts.should == [mt2, mt1]
		end

		#
		it "gets by name" do
			name = "test"
			create(:message_template, :name => name)
			mt = Sms::MessageTemplate.get_by_name(name)
			mt.should_not be_nil
		end

		#
		def self.create_by(params)
			attributes = attributes_for(:message_template)
			mt = Sms::MessageTemplate.create_by(attributes)
			mt.should be_valid
		end

		#
		def self.update_by_id(id, params)
			name = "test"
			mt = create(:message_template)
			mt = Sms::MessageTemplate.update_by_id(mt.id, :name => name)
			mt.should be_valid
			mt.name.should == name
		end

		#
		def self.destroy_by_id(id)
			mt = create(:message_template)
			Sms::MessageTemplate.destroy_by_id(mt.id)
		end
	end
end
