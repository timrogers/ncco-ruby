# frozen_string_literal: true

class IncomingCallsController < ApplicationController
  def create
    say_hello = {
      action: "talk",
      text: "Hello there! You're through to Acme Widgets. Leave a message.",
    }

    record_message = {
      action: "record",
      eventUrl: record_incoming_calls_url,
      eventMethod: "POST",
    }

    render json: NCCO.build([say_hello, record_message])
  end

  def record
    recording_url = params[:recording_url]
    conversation_uuid = params[:conversation_uuid]

    SaveRecordedMessage.call(recording_url: recording_url,
                             conversation_uuid: conversation_uuid)

    render status: 204, nothing: true
  end
end
