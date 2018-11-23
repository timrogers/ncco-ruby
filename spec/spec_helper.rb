# frozen_string_literal: true

require "bundler/setup"
require "pry"
require "ncco"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def load_fixture(*path)
  File.read(File.join("spec", "fixtures", File.join(*path)))
end

def load_json_fixture(*path)
  JSON.parse(load_fixture(*path))
end
