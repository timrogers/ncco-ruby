# frozen_string_literal: true

require "rspec/expectations"

RSpec::Matchers.define :allow_blank_values do
  attr_reader :attribute_name, :other_attributes

  match do |schema|
    unless attribute_name
      raise("You must chain the `allow_blank_values` matcher with " \
            "`for(:attribute_name)`, for example: " \
            "`it { is_expected.to_not allow_blank_values.for(:text) }`")
    end

    attributes = other_attributes || {}

    error_messages_with_blank = schema.
      call(attributes.merge(attribute_name => "")).
      messages[attribute_name]

    error_messages_with_nil = schema.
      call(attributes.merge(attribute_name => nil)).
      messages[attribute_name]

    error_messages_with_blank.nil? && error_messages_with_nil.nil?
  end

  chain :for do |attribute_name|
    @attribute_name = attribute_name
  end

  chain :with_attributes do |attributes|
    @other_attributes = attributes
  end

  failure_message do
    "expected that the schema would allow blank values (an empty string or `nil`) for " \
    "attribute #{attribute_name} but it didn't"
  end

  failure_message_when_negated do
    "expected that the schema would not allow blank values (an empty string or `nil`) " \
    "for attribute #{attribute_name}, but it allowed it"
  end
end
