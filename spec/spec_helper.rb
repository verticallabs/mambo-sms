require 'rubygems'
require 'bundler'

require 'rails'
Bundler.require(:default, :development, :assets) if defined?(Bundler)

$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path("../app", __FILE__)

require 'mambo-sms'
require 'mambo-authentication'
require 'capybara/rspec'

# combustion
require 'haml-rails'
Combustion.initialize!(:action_controller, :action_view, :action_mailer, :sprockets, :active_support)

# datamapper
DataMapper.finalize
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.setup(:in_memory, 'sqlite::memory:')
DataMapper.auto_migrate!

# capybara
module RSpec::CapybaraExtensions
  def rendered
    Capybara.string(@rendered)
  end
end

# factory_girl
require 'sms/support/factories'

# engine routing
require 'mambo/support/engine_router'
Mambo::Support::EngineRouter.load_engine_routes(:sms, :authentication)
require 'rails/application/route_inspector'
#abort Rails::Application::RouteInspector.new.format(Rails.application.routes.routes).join("\n")

require 'rack/test'
require 'rspec/rails'
require 'capybara/rails'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include RSpec::CapybaraExtensions, :type => :view
  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods, :type => :request
end
