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

# Used to "symbolise" Hash keys in our tests are loading from JSON. Taken from Rails
# (<https://apidock.com/rails/v4.0.2/Hash/deep_transform_keys>), with a refactor to
# make it "functional" rather than monkeypatching Hash
def deep_transform_keys(hash, &block)
  result = {}

  hash.each do |key, value|
    result[yield(key)] = value.is_a?(Hash) ? deep_transform_keys(value, &block) : value
  end

  result
end
