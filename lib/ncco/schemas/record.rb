# frozen_string_literal: true

module NCCO
  module Schemas
    DIGITS = (0..9).map(&:to_s).freeze

    Record = Dry::Validation.Schema(BaseSchema) do
      required(:action).value(eql?: "record")
      optional(:format).value(included_in?: %w[mp3 wav ogg])
      # TODO: Is nil allowed? What are the other options?
      optional(:split).value(included_in?: [nil, "conversation"])
      optional(:channels).value(type?: Integer, gteq?: 1, lteq?: 32)
      optional(:endOnSilence).value(type?: Integer, gteq?: 3, lteq?: 10)
      optional(:endOnKey).value(:phone_keypad_digit?)
      optional(:beepStart).value(:bool?)
      optional(:timeout).value(type?: Integer, gteq?: 3, lteq?: 7200)
      optional(:eventUrl).value(:http_or_https_url?)
      optional(:eventMethod).value(:supported_http_method?)
    end
  end
end
