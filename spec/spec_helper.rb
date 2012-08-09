#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
require "capybara/rspec"

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

  # include engine url helpers so we can use them in our specs
  config.include Sms::Engine.routes.url_helpers

  #config.include Rack::Test::Methods, :type => :request
end

# include engine url helpers in the views under test (this should happen automatically, but doesn't)
ActionView::TestCase::TestController.send(:include, Sms::Engine.routes.url_helpers)

# capybara

#module RSpec::CapybaraExtensions
#  def rendered
#    Capybara.string(@rendered)
#  end
#end
