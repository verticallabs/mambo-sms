# -*- encoding : utf-8 -*-
ENV["RAILS_ENV"] ||= "test"

require "rubygems"
require "bundler"

Bundler.require(:default, :assets, :development) if defined?(Bundler)

$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path("../app", __FILE__)

# combustion
Combustion.initialize!

spec_path = File.expand_path("../", __FILE__)

# factory_girl
Dir[File.join(spec_path, "factories", "**", "*.rb")].each { |f| require f }

require "rack/test"
require "rspec/rails"
#require "capybara/rails"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
  	Rails.logger.debug(example.full_description)
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Sms::Engine.routes.url_helpers

  #config.include Rack::Test::Methods, :type => :request
  #config.include RSpec::CapybaraExtensions, :type => :view
end

# capybara
#require "capybara/rspec"
#module RSpec::CapybaraExtensions
#  def rendered
#    Capybara.string(@rendered)
#  end
#end
