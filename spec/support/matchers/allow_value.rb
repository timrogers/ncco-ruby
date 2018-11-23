# frozen_string_literal: true

require "rspec/expectations"

RSpec::Matchers.define :allow_value do |value|
  attr_reader :attribute_name, :error_messages

  match do |schema|
    unless attribute_name
      raise("You must chain the `allow_value` matcher with `for(:attribute_name)`, " \
            "for example: `it { is_expected.to allow_value(\"Hello!\").for(:text) }`")
    end

    @error_messages = schema.call(attribute_name => value).
      messages[attribute_name]

    error_messages.nil?
  end

  chain :for do |attribute_name|
    @attribute_name = attribute_name
  end

  failure_message do
    "expected that the schema would allow value #{value.inspect} for attribute " \
    "#{attribute_name} but it didn't, triggering the following errors: #{error_messages}"
  end

  failure_message_when_negated do
    "expected that the schema would not allow value #{value.inspect} for attribute " \
    "#{attribute_name}, but it allowed it"
  end
end
