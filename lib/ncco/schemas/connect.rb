# frozen_string_literal: true

module NCCO
  module Schemas
    ConnectPhoneEndpoint = Dry::Validation.Schema(BaseSchema) do
      required(:type).value(eql?: "phone")

      required(:number).value(:e164?)
      optional(:onAnswer).value(:http_or_https_url?)
      optional(:dtmfAnswer).value(:phone_keypad_digits?)
    end

    ConnectSipEndpoint = Dry::Validation.Schema(BaseSchema) do
      required(:type).value(eql?: "sip")

      required(:uri).value(:sip_uri?)
    end

    ConnectWebSocketEndpoint = Dry::Validation.Schema(BaseSchema) do
      required(:type).value(eql?: "websocket")

      required(:uri).value(:websocket_url?)
      optional("content-type").value(eql?: "audio/l16;rate=16000")
      optional(:headers).value(:hash_with_string_keys_and_values?)
    end

    ConnectEndpoint = Dry::Validation.Schema(BaseSchema) do
      required(:type).value(included_in?: %w[phone websocket sip])

      # How we validate the endpoint (i.e. what schema we should use) depends on the type
      rule(phone_endpoint: [:type]) do |type|
        type.eql?("phone") > schema(ConnectPhoneEndpoint)
      end

      rule(sip_endpoint: [:type]) do |type|
        type.eql?("sip") > schema(ConnectSipEndpoint)
      end

      rule(websocket_endpoint: [:type]) do |type|
        type.eql?("websocket") > schema(ConnectWebSocketEndpoint)
      end

      # We use this special `anything?` predicate to declare and whitelist the
      # attribute without setting any rules for they must look like. The values
      # are validated by our endpoint-specific schemas.
      optional(:number).value(:anything?)
      optional(:onAnswer).value(:anything?)
      optional(:dtmfAnswer).value(:anything?)
      optional(:uri).value(:anything?)
      optional("content-type").value(:anything?)
      optional(:headers).value(:anything?)
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
