ENV["RAILS_ENV"] ||= 'test'

#boot.rb
require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

#application.rb
require 'action_controller/railtie'
#require 'dm-rails/railtie'
#require 'sprockets/railtie'
#require 'action_mailer/railtie'
#require 'active_resource/railtie'
#require 'rails/test_unit/railtie'
Bundler.require(*Rails.groups(:assets => %w(development test))) if defined?(Bundler)

#rspec
require 'rspec/rails'
require 'rspec/autorun'

#gem specific
gem_root = File.join(File.dirname(__FILE__), '..')
$:.push File.expand_path(File.join(gem_root, 'app', 'models'))
require 'sms'
require 'sms/subscriber'
require 'sms/message'
require 'active_support'
Dir[File.join(gem_root, 'spec', 'support', '**', '*.rb')].each {|f| require f}

#factory_girl
FactoryGirl.find_definitions

#datamapper
DataMapper.finalize
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.auto_migrate!

#configure
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.infer_base_class_for_anonymous_controllers = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

RSpec::Matchers.define :be_valid do
  match(&:valid?)

  failure_message_for_should do |record|
    "expected #{record.class} #{record.to_param} to be valid, but got the following errors:\n#{formatted_errors(record)}"
  end

  def formatted_errors(record)
    record.errors.full_messages.join("\n")
  end
end
