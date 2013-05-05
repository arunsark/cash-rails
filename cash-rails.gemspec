$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cash-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cash-rails"
  s.version     = CashRails::VERSION
  s.authors     = ["Arun Vydianathan"]
  s.email       = ["arun.vydianathan@gmail.com"]
  s.homepage    = "https://github.com/arunsark/cash-rails"
  s.summary     = "Cashrb with Rails"
  s.description = "Easy way to integrate cashrb with Active Record."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = s.files.grep(/^spec\//)

  s.require_path = "lib"

  s.add_dependency "cashrb"
  s.add_dependency "activesupport", ">= 3.0"
  s.add_dependency "railties",      ">= 3.0"

  s.add_development_dependency "rails",       ">= 3.0"
  s.add_development_dependency "rspec-rails", "~> 2.10"
  s.add_development_dependency 'database_cleaner', ['>= 0.8.0']
end
