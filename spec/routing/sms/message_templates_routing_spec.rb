require 'spec_helper'

describe "routing to message templates" do
  it "routes to index" do
    { :get => "/sms/message_templates" }.should route_to(:controller => "sms/message_templates", :action => "index")
  end

  it "routes to new" do
    { :get => "/sms/message_templates/new" }.should route_to(:controller => "sms/message_templates", :action => "new")
  end

  it "routes to create" do
    { :post => "/sms/message_templates" }.should route_to(:controller => "sms/message_templates", :action => "create")
  end

  it "routes to edit" do
    { :get => "/sms/message_templates/1/edit" }.should route_to(:controller => "sms/message_templates", :action => "edit", :id => '1')
  end

  it "routes to update" do
    { :put => "/sms/message_templates/1" }.should route_to(:controller => "sms/message_templates", :action => "update", :id => '1')
  end

  it "routes to destroy" do
    { :delete => "/sms/message_templates/1" }.should route_to(:controller => "sms/message_templates", :action => "destroy", :id => '1')
  end
end
