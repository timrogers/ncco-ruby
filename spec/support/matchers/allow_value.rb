# frozen_string_literal: true

require "rspec/expectations"

# We keep the specs for our schemas very declarative and clear by specifying values
# which should and should not be accepted by the schema. This `allow_value` matcher
# makes that easy and simple, without having to understand what's going on under the
# hood.
RSpec::Matchers.define :allow_value do |value|
  attr_reader :attribute_name, :other_attributes, :error_messages

  match do |schema|
    unless attribute_name
      raise("You must chain the `allow_value` matcher with `for(:attribute_name)`, " \
            "for example: `it { is_expected.to allow_value(\"Hello!\").for(:text) }`")
    end

    attributes = (other_attributes || {}).merge(attribute_name => value)

    @error_messages = schema.call(attributes).
      messages[attribute_name]

    error_messages.nil?
  end

  chain :for do |attribute_name|
    @attribute_name = attribute_name
  end

  chain :with_attributes do |attributes|
    @other_attributes = attributes
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
