# frozen_string_literal: true

require "dry-validation"
require "ncco/version"
require "ncco/predicates"
require "ncco/schemas/base_schema"
require "ncco/schemas/connect"
require "ncco/schemas/conversation"
require "ncco/schemas/input"
require "ncco/schemas/record"
require "ncco/schemas/stream"
require "ncco/schemas/talk"
require "ncco/utils"

module NCCO
  class InvalidActionError < StandardError; end

  # Maps the "action" attribute within an action to the schema which should be used
  # to validate it
  SCHEMAS_BY_TYPE = {
    "connect" => Schemas::Connect,
    "conversation" => Schemas::Conversation,
    "input" => Schemas::Input,
    "record" => Schemas::Record,
    "stream" => Schemas::Stream,
    "talk" => Schemas::Talk,
  }.freeze

  # A Nexmo Call Control Object (NCCO) is a JSON array that you use to control the flow
  # of a Nexmo call. This method validates an array, ensuring the "actions" inside are
  # valid NCCO actions, either throwing an explanatory error if they're not, or returning
  # back the array if the input is valid.
  #
  # This method can be used to pre-emptively ensure that an NCCO is valid *before* sending
  # it to Nexmo, providing a kind of static analysis.
  #
  # @param actions [Array<Hash>] a Nexmo Call Control Object (NCCO) as a Ruby array, made
  #   up of a series of "actions", each of which is a Ruby hash
  # @return [Array<Hash>] the Nexmo Call Control Object (NCCO), as a Ruby array, which
  #   was passed in
  # @raise [InvalidActionError] if any of the actions within the Nexmo Call Control
  #   Object is invalid. The error message will include details on which action was
  #   invalid and why.
  def self.build(actions)
    actions.
      map { |action| Utils.deep_transform_keys_to_symbols(action) }.
      each_with_index { |action, index| validate_action!(action, index: index) }

    actions
  end

  class << self
    private

    # Validates an NCCO action, raising an error if it is invalid
    #
    # @param action [Hash] the NCCO action
    # @param index [Integer] the position of the action in the NCCO array
    # @raise [InvalidActionError] if the action is invalid
    def validate_action!(action, index:)
      schema = SCHEMAS_BY_TYPE[action[:action]]

      unless schema
        raise_invalid_error("#{action[:action]} isn't a valid action type",
                            index: index)
      end

      result = schema.call(action)
      error_message = get_error_message_from_result(result)

      raise_invalid_error(error_message, index: index) if error_message
    end

    # Raises an InvalidActionError, featuring the human-readable index of the action
    # within the provided NCCO object, with a specified error message
    #
    # @param error_message [String] the specific error message
    # @param index [Integer] the zero-indexed position of the action within the NCCO
    #   object
    # @raise [InvalidActionError]
    def raise_invalid_error(error_message, index:)
      raise InvalidActionError, "The #{ordinalised_number(index + 1)} action is " \
                                "invalid: #{error_message}"
    end

    # Finds a number's "ordinal string", used to denote its position in an ordered
    # sequence, and returns the number followed by that string. See `#ordinalize` for
    # further information.
    #
    # @param number [Integer] the number to fetch the ordinal string for
    # @return [String] the number, followed by the ordinal string corresponding to the
    #   number
    def ordinalised_number(number)
      "#{number}#{ordinal_string_for_number(number)}"
    end

    # Turns a number into an "ordinal string" used to denote its position in an ordered
    # sequence - for example passing in 1 returns "st" (1st), 2 returns "nd" (2nd), etc.
    #
    # @param number [Integer] the number to fetch the ordinal string for
    # @return [String] the ordinal string corresponding to the number
    def ordinal_string_for_number(number)
      case number.digits.last
      when 0 then "th"
      when 1 then "st"
      when 2 then "nd"
      when 3 then "rd"
      when 4..9 then "th"
      end
    end

    # Gets the error messages from a `Dry::Validation::Result`, if there is one, dealing
    # with the slightly mad `Result` API
    #
    # @param result [Dry::Validation::Result] the result from validating an action against
    #   a schema
    # @return [String, nil] an error message to display, if there was an error
    def get_error_message_from_result(result)
      error_messages = result.messages(full: true)
      return if error_messages.none?

      transform_error_message(error_messages)
    end

    def transform_error_message(error_messages)
      case error_messages
      when String then errror_messages
      when Array then error_messages.first
      when Hash then transform_error_message(error_messages.values.first)
      else raise ArgumentError, "Unable to parse error message"
      end
    end
  end
end
