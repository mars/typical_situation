$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "typical_situation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "typical_situation"
  s.version     = TypicalSituation::VERSION
  s.authors     = ["Mars Hall"]
  s.email       = ["m@marsorange.com"]
  s.homepage    = "https://github.com/mars/typical_situation"
  s.summary     = "The missing Rails ActionController REST API mixin."
  s.description = "A module providing the seven standard resource actions & responses for an ActiveRecord :model_type & :collection."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"
  
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "factory_girl_rails", "~> 4.0"
end
