Rails.application.routes.draw do
  mount Sms::Engine => '/sms'
  mount Authentication::Engine => '/authentication'
end
