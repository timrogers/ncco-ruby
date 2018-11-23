# frozen_string_literal: true

require "rspec/expectations"

RSpec::Matchers.define :allow_attribute do |attribute_name|
  match do |schema|
    error_messages = schema.call(attribute_name => "anything").
      messages

    error_messages.nil?
  end

  failure_message do
    "expected that the schema would allow attribute #{attribute_name}"
  end

  failure_message_when_negated do
    "expected that the schema would not allow attribute #{attribute_name}"
  end
end
