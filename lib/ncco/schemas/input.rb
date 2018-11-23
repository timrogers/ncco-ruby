# frozen_string_literal: true

module NCCO
  module Schemas
    Input = Dry::Validation.Schema(BaseSchema) do
      required(:action).value(eql?: "input")
      optional(:timeOut).value(type?: Integer, gteq?: 1, lteq?: 10)
      optional(:maxDigits).value(type?: Integer, gteq?: 1, lteq?: 20)
      optional(:submitOnHash).value(:bool?)
      optional(:eventUrl).value(:http_or_https_url?)
      optional(:eventMethod).value(:supported_http_method?)
    end
  end
end
