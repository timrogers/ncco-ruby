# frozen_string_literal: true

module NCCO
  module Schemas
    Conversation = Dry::Validation.Schema(BaseSchema) do
      required(:action).value(eql?: "conversation")
      required(:name).value(:filled?, type?: String)
      optional(:musicOnHoldUrl).value(:http_or_https_url?)
      optional(:startOnEnter).value(:bool?)
      optional(:endOnExit).value(:bool?)
      optional(:record).value(:bool?)
      optional(:eventUrl).value(:http_or_https_url?)
      optional(:eventMethod).value(:supported_http_method?)
    end
  end
end
