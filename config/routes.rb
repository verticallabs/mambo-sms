Sms::Engine.routes.draw do
	resources(:messages, :only => [:index, :show])
end
