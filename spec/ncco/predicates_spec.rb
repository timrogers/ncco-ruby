# frozen_string_literal: true

RSpec.describe NCCO::Predicates do
  subject(:is_valid?) { described_class[predicate].call(input) }

  describe "e164?" do
    let(:predicate) { :e164? }

    context "with a valid E.164 formatted UK phone number" do
      let(:input) { "+442071838674" }

      it { is_expected.to be_truthy }
    end

    context "with a valid E.164 formatted US phone number" do
      let(:input) { "+14155552671" }

      it { is_expected.to be_truthy }
    end

    context "with a non-E.164 formatted UK phone number" do
      let(:input) { "02071838674" }

      it { is_expected.to be_falsey }
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end

  describe "http_or_https_url?" do
    let(:predicate) { :http_or_https_url? }

    context "with an HTTP URL" do
      let(:input) { "http://timrogers.co.uk" }

      it { is_expected.to be_truthy }
    end

    context "with an HTTPS URL" do
      let(:input) { "https://timrogers.co.uk" }

      it { is_expected.to be_truthy }
    end

    context "with a URL that isn't HTTP or HTTPS" do
      let(:input) { "ws://timrogers.co.uk" }

      it { is_expected.to be_falsey }
    end

    context "with an invalid URL" do
      let(:input) { "foo" }

      it { is_expected.to be_falsey }
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end

  describe "http_or_https_url?" do
    let(:predicate) { :websocket_url? }

    context "with an Websocket URL" do
      let(:input) { "ws://timrogers.co.uk" }

      it { is_expected.to be_truthy }
    end

    context "with an HTTP URL" do
      let(:input) { "http://timrogers.co.uk" }

      it { is_expected.to be_falsey }
    end

    context "with an HTTPS URL" do
      let(:input) { "https://timrogers.co.uk" }

      it { is_expected.to be_falsey }
    end

    context "with an invalid URL" do
      let(:input) { "foo" }

      it { is_expected.to be_falsey }
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end

  describe "supported_http_method?" do
    let(:predicate) { :supported_http_method? }

    context "with GET" do
      let(:input) { "GET" }

      it { is_expected.to be_truthy }
    end

    context "with POST" do
      let(:input) { "GET" }

      it { is_expected.to be_truthy }
    end

    context "with something else" do
      let(:input) { "PUT" }

      it { is_expected.to be_falsey }
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end

  describe "phone_keypad_digit?" do
    let(:predicate) { :phone_keypad_digit? }

    context "with a number from a phone as a string" do
      let(:input) { "1" }

      it { is_expected.to be_truthy }
    end

    context "with an asterisk" do
      let(:input) { "*" }

      it { is_expected.to be_truthy }
    end

    context "with a hash" do
      let(:input) { "#" }

      it { is_expected.to be_truthy }
    end

    context "with a number from a phone as an integer" do
      let(:input) { 1 }

      it { is_expected.to be_falsey }
    end

    context "with a random string" do
      let(:input) { "asdasd" }

      it { is_expected.to be_falsey }
    end

    context "with numbers, but unexpected spacing" do
      let(:input) { "123 456" }

      it { is_expected.to be_falsey }
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end

  describe "phone_keypad_digits?" do
    let(:predicate) { :phone_keypad_digits? }

    context "with a series of numbers from a phone as a string" do
      let(:input) { "123567890" }

      it { is_expected.to be_truthy }
    end

    context "with numbers and special characters from the phone keypad" do
      let(:input) { "123567890*#" }

      it { is_expected.to be_truthy }
    end

    context "with just special characters from the phone keypad" do
      let(:input) { "*#" }

      it { is_expected.to be_truthy }
    end

    context "with a number from a phone as an integer" do
      let(:input) { 1 }

      it { is_expected.to be_falsey }
    end

    context "with a random string" do
      let(:input) { "asdasd" }

      it { is_expected.to be_falsey }
    end

    context "with numbers and special characters, but unexpected spacing" do
      let(:input) { "123 456*#" }

      it { is_expected.to be_falsey }
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end

  describe "hash_with_string_keys_and_values?" do
    let(:predicate) { :hash_with_string_keys_and_values? }

    describe "with a hash with string keys and values" do
      let(:input) { { "X-Favourite-Dessert" => "Pumpkin Pie" } }

      it { is_expected.to be_truthy }

      context "with multiple pairs" do
        let(:input) do
          {
            "X-Favourite-Dessert" => "Pumpkin Pie",
            "X-Favourite-Tipple" => "Mulled Wine",
          }
        end

        it { is_expected.to be_truthy }
      end
    end

    describe "with a non-hash" do
      let(:input) { "X-Favourite-Dessert: Pumpkin Pie" }

      it { is_expected.to be_falsey }
    end

    describe "with a hash with non-string keys and values" do
      let(:input) { { "X-Favourite-Dessert": "Pumpkin Pie" } }

      it { is_expected.to be_falsy }

      context "with multiple pairs" do
        let(:input) do
          {
            "X-Favourite-Dessert": "Pumpkin Pie",
            "X-Favourite-Tipple": "Mulled Wine",
          }
        end

        it { is_expected.to be_falsy }
      end
    end

    context "with nil" do
      let(:input) { nil }

      it { is_expected.to be_falsey }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_falsey }
    end
  end
end
