# frozen_string_literal: true

require "rspec/expectations"

# dry-validations schemas separate key and value validation. So for example:
#
# * You can say that this key *must* be specified, but I don't care what the
#   value is (it could even be `nil`!).
# * Equally, you can see that I don't care whether this key is specified, but
#   if it is, the value must look like this.
#
# This handy matcher checks that a key is required, without setting any
# conditions about the value.
RSpec::Matchers.define :require_attribute do |attribute_name|
  attr_reader :other_attributes

  match do |schema|
    error_messages = schema.call(other_attributes || {}).
      messages[attribute_name]

    error_messages&.include?("is missing")
  end

  chain :with_attributes do |attributes|
    @other_attributes = attributes
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
