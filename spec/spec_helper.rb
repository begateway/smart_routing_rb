require "bundler/setup"
require "smart_routing"

require 'webmock/rspec'

require "support/client_helpers"
require "support/admin_response_fixtures"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ClientHelpers
end
