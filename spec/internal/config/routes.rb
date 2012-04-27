Rails.application.routes.draw do
  root :to => 'sms/message_templates#index'
  mount Sms::Engine => '/sms'
  mount Authentication::Engine => '/authentication'
end
