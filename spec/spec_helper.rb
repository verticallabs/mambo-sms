require 'rubygems'
require 'bundler'

require 'rails'
Bundler.require(:default, :development, :assets) if defined?(Bundler)

$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path("../app", __FILE__)

require 'mambo-sms'
require 'mambo-authentication'

# combustion
require 'haml-rails'
Combustion.initialize!(:action_controller, :action_view, :action_mailer, :sprockets, :active_support)

# datamapper
DataMapper.finalize
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.setup(:in_memory, 'sqlite::memory:')
DataMapper.auto_migrate!

# factory_girl
require 'sms/support/factories' 

# engine routing
require 'mambo/support/engine_router'
Sms::Engine.load_engine_routes

require 'rspec/rails'

RSpec.configure do |config|
  config.before(:each) do
    Sms::Subscriber.all.destroy
    Sms::Message.all.destroy
    Sms::MessageTemplate.all.destroy
  end

  config.include FactoryGirl::Syntax::Methods
end
