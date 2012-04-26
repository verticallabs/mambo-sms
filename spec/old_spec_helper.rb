ENV["RAILS_ENV"] ||= 'test'

#boot.rb
require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

#application.rb
require 'rails'
require 'action_controller'
Bundler.require(*Rails.groups(:assets => %w(development test))) if defined?(Bundler)

#rspec
require 'rspec/rails'
require 'rspec/autorun'

# add dirs to load_path
gem_root = File.join(File.dirname(__FILE__), '..')
Dir[File.join(gem_root, 'app', '**', '*')].each do |f| 
  if Dir.exist?(f)
    $: << File.expand_path(f)
  end
end

# hijack rails autoload system
include ActiveSupport
$:.each do |path|
  Dependencies.autoload_paths << File.expand_path(path)
end

# load support
Dir[File.join(gem_root, 'spec', 'support', '**', '*.rb')].each {|f| require f}

# factory_girl
FactoryGirl.find_definitions

# datamapper
DataMapper.finalize
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.auto_migrate!

class SpecApplication < Rails::Application
end

# routes
require File.expand_path('../../config/routes', __FILE__)
::Rails.application.routes.disable_clear_and_finalize = true
::Rails.application.routes.clear!
::Rails.application.routes_reloader.paths.each { |path| load(path) }
::Rails.application.routes.draw do
  #mount Sms::Engine => '/sms'
  root :to => 'test#test'
end
::Rails.application.routes.finalize!
::Rails.application.routes.disable_clear_and_finalize = false
::Rails.application.initialize!

require 'rails/application/route_inspector'
inspector = Rails::Application::RouteInspector.new
puts inspector.format(::Rails.application.routes.routes).join "\n"

#configure
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.infer_base_class_for_anonymous_controllers = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    Sms::Subscriber.all.destroy
    Sms::Message.all.destroy
    Sms::MessageTemplate.all.destroy
  end
end
