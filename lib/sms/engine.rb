module Sms
  class Engine < Rails::Engine
    isolate_namespace Sms

		#
    initializer "models" do
    	require "sms/message"
    	require "sms/subscriber"
    	require "sms/message_template"
    end

		#
    initializer "i18n" do
    	I18n.load_path += Dir[File.join(__FILE__, "config", "locales", "**", "*.{rb,yml}")]
    end
  end
end
