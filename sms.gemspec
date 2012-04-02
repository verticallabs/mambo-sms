# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sms/version"

Gem::Specification.new do |s|
  s.name        = "mambo-sms"
  s.version     = Sms::VERSION
  s.authors     = ["Chris Dion"]
  s.email       = ["chris@verticallabs.ca"]
  s.homepage    = ""
  s.summary     = %q{Mambo SMS}
  s.description = %q{Mambo SMS}

  s.rubyforge_project = "mambo_sms"

	s.files = Dir["{app,config,lib}/**/*"] + ["Rakefile"]
	s.test_files = Dir["test/**/*"]
  s.require_paths = Dir["lib/*"]

  # specify any dependencies here; for example:
  SMS_DM_VERSION = "~> 1.2"
	s.add_runtime_dependency "dm-rails", SMS_DM_VERSION
	s.add_runtime_dependency "dm-types", SMS_DM_VERSION
	s.add_runtime_dependency "dm-validations", SMS_DM_VERSION
	s.add_runtime_dependency "dm-constraints", SMS_DM_VERSION
	s.add_runtime_dependency "dm-transactions", SMS_DM_VERSION
	s.add_runtime_dependency "dm-timestamps", SMS_DM_VERSION	
	s.add_runtime_dependency "dm-pager"
	
	s.add_development_dependency "rspec-rails"
end
