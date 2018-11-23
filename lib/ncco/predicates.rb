# frozen_string_literal: true

module NCCO
  module Predicates
    include ::Dry::Logic::Predicates

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
    DIGITS = [*NUMBERS, "*", "#"].freeze

    predicate(:single_digit?) do |value|
      DIGITS.include?(value)
    end

    predicate(:digits?) do |value|
      value.is_a?(String) &&
        !value.empty? &&
        (value.chars - DIGITS).none?
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
