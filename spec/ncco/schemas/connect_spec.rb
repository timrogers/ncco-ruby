# frozen_string_literal: true

RSpec.describe NCCO::Schemas::Connect do
  subject(:schema) { described_class }

  describe "action" do
    it { is_expected.to require_attribute(:action) }
    it { is_expected.to allow_value("connect").for(:action) }
    it { is_expected.to_not allow_value("something else").for(:action) }
    it { is_expected.to_not allow_blank_values.for(:action) }
  end

  describe "from" do
    it { is_expected.to_not require_attribute(:from) }
    it { is_expected.to allow_value("+14155552671").for(:from) }
    it { is_expected.to allow_value("+442071838750").for(:from) }
    it { is_expected.to_not allow_value("020718388674").for(:from) }
    it { is_expected.to_not allow_blank_values.for(:from) }
  end

  describe "eventType" do
    it { is_expected.to_not require_attribute(:eventType) }
    it { is_expected.to allow_value("synchronous").for(:eventType) }
    it { is_expected.to_not allow_value("something else").for(:eventType) }
    it { is_expected.to_not allow_blank_values.for(:eventType) }
  end

  describe "timeout" do
    it { is_expected.to_not require_attribute(:timeout) }
    it { is_expected.to allow_value(1).for(:timeout) }
    it { is_expected.to allow_value(100).for(:timeout) }
    it { is_expected.to_not allow_value(0).for(:timeout) }
    it { is_expected.to_not allow_value(-1).for(:timeout) }
    it { is_expected.to_not allow_value(100.1).for(:timeout) }
    it { is_expected.to_not allow_blank_values.for(:timeout) }
  end

  describe "limit" do
    it { is_expected.to_not require_attribute(:limit) }
    it { is_expected.to allow_value(1).for(:limit) }
    it { is_expected.to allow_value(7200).for(:limit) }
    it { is_expected.to_not allow_value(0).for(:limit) }
    it { is_expected.to_not allow_value(-1).for(:limit) }
    it { is_expected.to_not allow_value(100.1).for(:limit) }
    it { is_expected.to_not allow_blank_values.for(:limit) }
  end

  describe "machineDetection" do
    it { is_expected.to_not require_attribute(:machineDetection) }
    it { is_expected.to allow_value("continue").for(:machineDetection) }
    it { is_expected.to allow_value("hangup").for(:machineDetection) }
    it { is_expected.to_not allow_value("something else").for(:machineDetection) }
    it { is_expected.to_not allow_blank_values.for(:machineDetection) }
  end

  describe "eventUrl" do
    it { is_expected.to_not require_attribute(:eventUrl) }
    it { is_expected.to allow_value("http://foo.bar").for(:eventUrl) }
    it { is_expected.to allow_value("https://foo.bar").for(:eventUrl) }
    it { is_expected.to_not allow_value("foo").for(:eventUrl) }
    it { is_expected.to_not allow_value("ftp://foo.bar").for(:eventUrl) }
    it { is_expected.to_not allow_blank_values.for(:eventUrl) }
  end

  describe "eventMethod" do
    it { is_expected.to_not require_attribute(:eventMethod) }
    it { is_expected.to allow_value("GET").for(:eventMethod) }
    it { is_expected.to allow_value("POST").for(:eventMethod) }
    it { is_expected.to_not allow_value("PUT").for(:eventMethod) }
    it { is_expected.to_not allow_blank_values.for(:eventMethod) }
  end

  describe "endpoint" do
    it { is_expected.to require_attribute(:endpoint) }

    describe NCCO::Schemas::ConnectEndpoint do
      describe "type" do
        it { is_expected.to require_attribute(:type) }
        it { is_expected.to allow_value("phone").for(:type) }
        it { is_expected.to allow_value("websocket").for(:type) }
        it { is_expected.to allow_value("sip").for(:type) }
        it { is_expected.to_not allow_value("something else").for(:type) }
        it { is_expected.to_not allow_blank_values.for(:type) }
      end

      describe "number" do
        context "when the endpoint type is set to phone" do
          specify do
            expect(schema).to require_attribute(:number).with_attributes(type: "phone")
          end

          specify do
            expect(schema).to allow_value("+442071838674").for(:number).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to allow_value("+14155552671").for(:number).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_value("02071838674").for(:number).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_value("something else").for(:number).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_blank_values.for(:number).
              with_attributes(type: "phone")
          end
        end

        context "when the endpoint type is set to something else" do
          specify do
            expect(schema).to_not allow_attribute(:number).with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_attribute(:number).
              with_attributes(type: "websocket")
          end
        end
      end

      describe "onAnswer" do
        context "when the endpoint type is set to phone" do
          specify do
            expect(schema).to_not require_attribute(:onAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to allow_value("http://foo.bar").for(:onAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to allow_value("https://foo.bar").for(:onAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_value("foo").for(:onAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_value("ftp://foo.bar").for(:onAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_blank_values.for(:onAnswer).
              with_attributes(type: "phone")
          end
        end

        context "when the endpoint type is set to something else" do
          specify do
            expect(schema).to_not allow_attribute(:onAnswer).with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_attribute(:onAnswer).
              with_attributes(type: "websocket")
          end
        end
      end

      describe "dtmfAnswer" do
        context "when the endpoint type is set to phone" do
          specify do
            expect(schema).to_not require_attribute(:dtmfAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to allow_value("123*456#").for(:dtmfAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to allow_value("1").for(:dtmfAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_value(1).for(:dtmfAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_value("1234ab").for(:dtmfAnswer).
              with_attributes(type: "phone")
          end

          specify do
            expect(schema).to_not allow_blank_values.for(:dtmfAnswer).
              with_attributes(type: "phone")
          end
        end

        context "when the endpoint type is set to something else" do
          specify do
            expect(schema).to_not allow_attribute(:dtmfAnswer).
              with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_attribute(:dtmfAnswer).
              with_attributes(type: "websocket")
          end
        end
      end

      describe "uri" do
        context "when the endpoint type is set to websocket" do
          specify do
            expect(schema).to require_attribute(:uri).with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to allow_value("ws://foo.bar").for(:uri).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_value("foo").for(:uri).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_value("http://foo.bar").for(:uri).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_blank_values.for(:uri).
              with_attributes(type: "websocket")
          end
        end

        context "when the endpoint type is set to sip" do
          specify do
            expect(schema).to require_attribute(:uri).with_attributes(type: "sip")
          end

          specify do
            expect(schema).to allow_value("sip:123@sip.example.com").
              for(:uri).with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_value("foo").for(:uri).
              with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_value("http://foo.bar").
              for(:uri).with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_blank_values.
              for(:uri).with_attributes(type: "sip")
          end
        end

        context "when the endpoint type is set to phone" do
          specify do
            expect(schema).to_not allow_attribute(:uri).with_attributes(type: "phone")
          end
        end
      end

      describe "content-type" do
        context "when the endpoint type is set to websocket" do
          specify do
            expect(schema).to_not require_attribute("content-type").
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to allow_value("audio/l16;rate=16000").
              for("content-type").with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_value("something else").for("content-type").
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_blank_values.for("content-type").
              with_attributes(type: "websocket")
          end
        end

        context "when the endpoint type is set to something else" do
          specify do
            expect(schema).to_not allow_attribute("content-type").
              with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_attribute("content-type").
              with_attributes(type: "phone")
          end
        end
      end

      describe "headers" do
        context "when the endpoint type is set to websocket" do
          specify do
            expect(schema).to_not require_attribute(:headers).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to allow_value("foo" => "bar").for(:headers).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to allow_value("foo" => "bar", "bang" => "baz").for(:headers).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_value(foo: "bar").for(:headers).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_value(%w[foo bar]).for(:headers).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_value("foo: bar").for(:headers).
              with_attributes(type: "websocket")
          end

          specify do
            expect(schema).to_not allow_blank_values.for(:headers).
              with_attributes(type: "websocket")
          end
        end

        context "when the endpoint type is set to something else" do
          specify do
            expect(schema).to_not allow_attribute(:headers).with_attributes(type: "sip")
          end

          specify do
            expect(schema).to_not allow_attribute(:headers).
              with_attributes(type: "phone")
          end
        end
      end

      it { is_expected.to_not allow_attribute(:foo) }
    end
  end
end
