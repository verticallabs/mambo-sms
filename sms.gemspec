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

  s.rubyforge_project = "mambo-sms"

	s.files = Dir["{app,config,lib}/**/*"] + ["Rakefile"]
	s.test_files = Dir["spec/**/*"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "rails"
	s.add_runtime_dependency "dm-rails", Sms::DM_VERSION
	s.add_runtime_dependency "dm-types", Sms::DM_VERSION
	s.add_runtime_dependency "dm-validations", Sms::DM_VERSION
	s.add_runtime_dependency "dm-migrations", Sms::DM_VERSION
	s.add_runtime_dependency "dm-constraints", Sms::DM_VERSION
	s.add_runtime_dependency "dm-transactions", Sms::DM_VERSION
	s.add_runtime_dependency "dm-timestamps", Sms::DM_VERSION	
	s.add_runtime_dependency "will_paginate"
	s.add_runtime_dependency "haml-rails"
	s.add_runtime_dependency "mambo-authentication"
	
	s.add_development_dependency "rspec-rails"
	s.add_development_dependency "factory_girl"
	s.add_development_dependency "dm-core", Sms::DM_VERSION
	s.add_development_dependency "dm-migrations", Sms::DM_VERSION
	s.add_development_dependency "dm-sqlite-adapter", Sms::DM_VERSION
	s.add_development_dependency "database_cleaner"
	s.add_development_dependency "capybara"
	s.add_development_dependency "combustion"	
	s.add_development_dependency "magic_encoding"
end
