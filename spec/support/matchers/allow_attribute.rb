# frozen_string_literal: true

require "rspec/expectations"

RSpec::Matchers.define :allow_attribute do |attribute_name|
  attr_reader :other_attributes

  match do |schema|
    attributes = (other_attributes || {}).merge(attribute_name => "anything")

    error_messages = schema.call(attributes).
      messages

    error_messages.nil?
  end

  chain :with_attributes do |attributes|
    @other_attributes = attributes
  end

  failure_message do
    "expected that the schema would allow attribute #{attribute_name}"
  end

  failure_message_when_negated do
    "expected that the schema would not allow attribute #{attribute_name}"
  end
end
