# frozen_string_literal: true

module NCCO
  module Schemas
    BaseSchema = Dry::Validation.Schema do
      input :hash?, :strict_keys?

      configure do
        predicates(Predicates)

        def strict_keys?(input)
          (input.keys - rules.keys).empty?
        end

        config.messages_file = File.join(File.dirname(__FILE__), "../data/errors.yml")
      end
    end
  end
end
