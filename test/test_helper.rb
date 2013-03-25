# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require "factory_girl_rails"
class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

# The sqlite in-memory database is being used, so load the schema on each run.
load File.expand_path("../dummy/db/schema.rb",  __FILE__)
