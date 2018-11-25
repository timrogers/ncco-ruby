# frozen_string_literal: true

module NCCO
  module Predicates
    include ::Dry::Logic::Predicates

    # TODO: Does Nexmo accept URLs relative to the current location?
    predicate(:http_or_https_url?) do |value|
      uri = URI.parse(value)
      %w[http https].include?(uri.scheme)
    rescue URI::InvalidURIError
      false
    end

    predicate(:websocket_url?) do |value|
      uri = URI.parse(value)
      uri.scheme == "ws"
    rescue URI::InvalidURIError
      false
    end

    # TODO: Check what HTTP methods are supported by Nexmo - presumably not the full set?
    # <https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods>
    predicate(:supported_http_method?) do |value|
      %w[GET POST].include?(value)
    end

    NUMBERS = (0..9).map(&:to_s).freeze
    PHONE_KEYPAD_DIGITS = [*NUMBERS, "*", "#"].freeze

    predicate(:phone_keypad_digit?) do |value|
      PHONE_KEYPAD_DIGITS.include?(value)
    end

    predicate(:phone_keypad_digits?) do |value|
      value.is_a?(String) &&
        !value.empty? &&
        # There shouldn't be any characters in the input that aren't keypad digits
        (value.chars - PHONE_KEYPAD_DIGITS).none?
    end

    predicate(:e164?) do |value|
      # Regular expression taken from https://www.twilio.com/docs/glossary/what-e164
      value =~ /^\+?[1-9]\d{1,14}$/
    end

    predicate(:hash_with_string_keys_and_values?) do |value|
      value.is_a?(Hash) &&
        value.keys.map(&:class).uniq == [String] &&
        value.values.map(&:class).uniq == [String]
    end
  end
end
