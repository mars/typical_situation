# frozen_string_literal: true

require 'bundler'

Bundler.require :default, :development

# If you're using all parts of Rails:
Combustion.initialize! :all

require 'rspec/rails'
require 'typical_situation'
require 'factory_bot_rails'

Dir[File.dirname(__FILE__) + '/factories/*.rb'].each { |f| require f }

RSpec.configure do |config|
  if Rails::VERSION::MAJOR < 5
    require 'rails/forward_compatible_controller_tests'
    config.include Rails::ForwardCompatibleControllerTests, type: :controller
  end

  config.include FactoryBot::Syntax::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
