#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe "with message templates routes" do
	before(:each) do
		# http://stackoverflow.com/questions/7691594/how-to-test-routes-in-a-rails-3-1-mountable-engine
		@routes = Sms::Engine.routes
	end

  it "routes to index" do
  	{ :get => '/message_templates' }.should route_to(:controller => 'sms/message_templates', :action => 'index')
  end

  it "routes to new" do
    { :get => "/message_templates/new" }.should route_to(:controller => "sms/message_templates", :action => "new")
  end

  it "routes to create" do
    { :post => "/message_templates" }.should route_to(:controller => "sms/message_templates", :action => "create")
  end

  it "routes to edit" do
    { :get => "/message_templates/1/edit" }.should route_to(:controller => "sms/message_templates", :action => "edit", :id => '1')
  end

  it "routes to update" do
    { :put => "/message_templates/1" }.should route_to(:controller => "sms/message_templates", :action => "update", :id => '1')
  end

  it "routes to destroy" do
    { :delete => "/message_templates/1" }.should route_to(:controller => "sms/message_templates", :action => "destroy", :id => '1')
  end
end
