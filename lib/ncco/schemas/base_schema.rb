# frozen_string_literal: true

module NCCO
  module Schemas
    BaseSchema = Dry::Validation.Schema do
      input :hash?, :strict_keys?

      configure do
        # `dry-validations` includes a bunch of "predicates" which you can use to
        # validate values. This includes some custom Nexmo-specific ones (e.g. for
        # phone digits and URLs).
        predicates(Predicates)

        # Used to validate that the input only includes keys that are defined in
        # the schema, implementing a slightly hacky "whitelisting" behaviour (which
        # for some reason isn't include in `dry-validations`!)
        def strict_keys?(input)
          (input.keys - rules.keys).empty?
        end

        config.messages_file = File.join(File.dirname(__FILE__), "../data/errors.yml")
      end
    end
  end
end
