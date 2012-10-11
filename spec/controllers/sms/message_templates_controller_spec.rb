#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe Sms::MessageTemplatesController do
  describe "with authenticated user" do
    before(:each) do
      controller.stub(:authenticated_user => build(:user))
    end

		#
		context "index" do
			before do
				create(:message_template)
				get(:index, :use_route => :sms)
			end

			it { should assign_to(:message_templates) }
			it { should respond_with(:success) }
			it { should render_template(:index) }
		end

		#
		context "new" do
			before do
				get(:new, :use_route => :sms)
			end

			it { should assign_to(:message_template) }
			it { should respond_with(:success) }
			it { should render_template(:new) }
		end

		#
		context "create" do
			before do
				message_template_attributes = attributes_for(:message_template)
				post(:create, :use_route => :sms, :message_template => message_template_attributes)
			end

			it { should assign_to(:message_template) }
			it { should respond_with(:redirect) }
			it { should set_the_flash }
		end

		#
		context "edit" do
			before do
				message_template = create(:message_template)
				get(:edit, :use_route => :sms, :id => message_template.id)
			end

			it { should assign_to(:message_template) }
			it { should respond_with(:success) }
			it { should render_template(:edit) }
		end

		#
		context "update" do
			before do
				message_template = create(:message_template)
				message_template_attributes = attributes_for(:message_template)
				put(:update, :use_route => :sms, :id => message_template.id, :message_template => message_template_attributes)
			end

			it { should assign_to(:message_template) }
			it { should respond_with(:redirect) }
			it { should set_the_flash }
		end

		#
		context "destroy" do
			before do
				message_template = create(:message_template)
				delete(:destroy, :use_route => :sms, :id => message_template.id)
			end

			it { should assign_to(:message_template) }
			it { should respond_with(:redirect) }
			it { should set_the_flash }
		end
  end
end
