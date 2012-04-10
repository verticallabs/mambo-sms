module Sms
  class Engine < Rails::Engine
    isolate_namespace Sms

    initializer "load dependencies" do
    	require "sms/message"
    	require "sms/subscriber"
    end
  end
end
