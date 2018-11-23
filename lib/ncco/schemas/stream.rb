# frozen_string_literal: true

module NCCO
  module Schemas
    Stream = Dry::Validation.Schema(BaseSchema) do
      required(:action).value(eql?: "stream")
      required(:streamUrl).value(:http_or_https_url?)
      optional(:bargeIn).value(:bool?)
      optional(:loop).value(type?: Integer)
      optional(:level).value(included_in?: [-1, 0, 1])
    end
  end
end
