# frozen_string_literal: true

module NCCO
  module Schemas
    # TODO: Validate these attributes depending on the specified endpoint type
    ConnectEndpoint = Dry::Validation.Schema(BaseSchema) do
      required(:type).value(included_in?: %w[phone websocket sip])

      # Phone endpoint attributes
      optional(:number).value(:e164?)
      optional(:onAnswer).value(:http_or_https_url?)
      optional(:dtmfAnswer).value(:phone_keypad_digits?)

      # WebSocket endpoint attributes
      optional(:uri).value(:websocket_url?) # Also used for SIP endpoints
      optional("content-type").value(eql?: "audio/l16;rate=16000")
      optional(:headers).value(:hash_with_string_keys_and_values?)
    end

    Connect = Dry::Validation.Schema(BaseSchema) do
      required(:action).value(eql?: "connect")
      required(:endpoint).schema(ConnectEndpoint)
      optional(:from).value(:e164?)
      # TODO: What are the other options? (e.g. what is the default?)
      optional(:eventType).value(included_in?: ["synchronous"])
      # TODO: Are there any limitations on timeout?
      optional(:timeout).value(type?: Integer, gteq?: 1)
      optional(:limit).value(type?: Integer, gteq?: 1, lteq?: 7200)
      optional(:machineDetection).value(included_in?: %w[continue hangup])
      optional(:eventUrl).value(:http_or_https_url?)
      optional(:eventMethod).value(:supported_http_method?)
    end
  end
end
