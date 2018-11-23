# frozen_string_literal: true

module NCCO
  module Schemas
    Talk = Dry::Validation.Schema(BaseSchema) do
      required(:action).value(eql?: "talk")
      required(:text).value(:filled?, type?: String)
      optional(:bargeIn).value(:bool?)
      optional(:loop).value(type?: Integer)
      optional(:level).value(included_in?: [-1, 0, 1])
      optional(:voiceName).value(:filled?, type?: String)
    end
  end
end
