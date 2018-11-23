# frozen_string_literal: true

require "active_support/core_ext/hash"

RSpec.describe NCCO do
  it "has a version number" do
    expect(NCCO::VERSION).to_not be nil
  end

  describe ".build" do
    subject(:build) { described_class.build(input) }

    describe "with valid input" do
      let(:input) { load_json_fixture("valid_ncco.json") }

      it { is_expected.to eq(input) }

      describe "with symbol keys" do
        let(:input) { load_json_fixture("valid_ncco.json").map(&:deep_symbolize_keys) }

        it { is_expected.to eq(input) }
      end
    end

    context "with invalid input" do
      context "due to an invalid action type" do
        let(:input) { load_json_fixture("invalid_action_type.json") }

        it "raises an error" do
          expect { build }.to raise_error(
            NCCO::InvalidActionError,
            "The 2nd action is invalid: recrd isn't a valid action type",
          )
        end
      end

      context "with a valid action type" do
        context "missing required attributes" do
          let(:input) { load_json_fixture("missing_required_attributes.json") }

          it "raises an error" do
            expect { build }.to raise_error(
              NCCO::InvalidActionError,
              "The 1st action is invalid: text is missing, text must be String",
            )
          end
        end

        context "with invalid attributes" do
          let(:input) { load_json_fixture("invalid_attributes.json") }

          it "raises an error" do
            expect { build }.to raise_error(
              NCCO::InvalidActionError,
              "The 2nd action is invalid: eventUrl must be a valid HTTP or " \
              "HTTPS URL",
            )
          end
        end

        context "with additional unsupported attributes" do
          let(:input) { load_json_fixture("unsupported_attributes.json") }

          it "raises an error" do
            expect { build }.to raise_error(
              NCCO::InvalidActionError,
              "The 2nd action is invalid:  has attributes which aren't part of the " \
              "NCCO specification",
            )
          end
        end
      end
    end
  end
end
