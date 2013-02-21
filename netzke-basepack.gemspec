require "./lib/netzke/basepack/version"

Gem::Specification.new do |s|
  s.name        = "netzke-basepack"
  s.version     = Netzke::Basepack::Version::STRING
  s.author      = "nomadcoder"
  s.email       = "nmcoder@gmail.com"
  s.homepage    = "http://netzke.org"
  s.summary     = "Pre-built Netzke components"
  s.description = "A set of feature-rich extendible Netzke components (such as Form, Grid, Window, TabPanel, etc) and component extensions which can be used as building blocks for your RIA"

  s.files         = Dir["{javascripts,lib,locales,stylesheets}/**/*", "[A-Z]*", "init.rb"] - ["Gemfile.lock"]
  s.test_files    = Dir["{test}/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'netzke-core', '~> 0.8.2'

  s.add_development_dependency 'rails', '~> 3.2.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'coffee-script'

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
