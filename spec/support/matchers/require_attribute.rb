# frozen_string_literal: true

require "rspec/expectations"

# Dry::Validation schemas separate key and value validation. So for example, you
# can independently say that this key *must* be specified, but I don't care what
# the value is (it could even be `nil`!). This handy matcher checks that the key
# is required. Validation of any value provided with `allow_value` is separate.
RSpec::Matchers.define :require_attribute do |attribute_name|
  match do |schema|
    error_messages = schema.call({}).
      messages[attribute_name]

    error_messages&.include?("is missing")
  end

  failure_message do
    "expected that the schema would require attribute #{attribute_name} to be " \
    "specified, but it didn't"
  end

  failure_message_when_negated do
    "expected that the schema would not require attribute #{attribute_name} to be " \
    "specified, but it required it"
  end
end
