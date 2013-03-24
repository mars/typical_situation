# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require "factory_girl_rails"
FactoryGirl.definition_file_paths << "../factories"
FactoryGirl.find_definitions

class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end
