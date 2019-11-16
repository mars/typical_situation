# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'typical_situation/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'typical_situation'
  s.version     = TypicalSituation::VERSION
  s.authors     = ['Mars Hall', 'Wyatt Kirby']
  s.email       = ['m@marsorange.com', 'wyatt@apsis.io']
  s.homepage    = 'https://github.com/mars/typical_situation'
  s.summary     = 'The missing Rails ActionController REST API mixin.'
  s.description = 'A module providing the seven standard resource actions & responses for an ActiveRecord :model_type & :collection.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_runtime_dependency 'rails', '>= 4.2.0'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'combustion'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3', '~> 1.3.6'
end
