$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sign_up_feature/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sign_up_feature"
  s.version     = SignUpFeature::VERSION
  s.authors     = ["Tamara Austin"]
  s.email       = ["tamara@openstile.com"]
  s.homepage    = ""
  s.summary     = "Summary of SignUpFeature."
  s.description = "Description of SignUpFeature."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.6"

  s.add_dependency 'chili', '~> 4.0'

  s.add_development_dependency "sqlite3"
end
