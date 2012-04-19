Sms::Engine.routes.draw do
	resources(:message_templates, :only => [:index, :new, :create, :edit, :update, :destroy])
end
