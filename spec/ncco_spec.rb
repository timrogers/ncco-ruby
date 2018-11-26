# frozen_string_literal: true

RSpec.describe NCCO do
  describe ".build" do
    subject(:build) { described_class.build(input) }

    describe "with valid input" do
      let(:input) { load_json_fixture("valid_ncco.json") }

      it { is_expected.to eq(input) }

      context "with symbol keys" do
        let(:input) do
          load_json_fixture("valid_ncco.json").map do |action|
            deep_transform_keys(action, &:to_sym)
          end
        end

        it { is_expected.to eq(input) }
      end

      context "with a 'connect' action (which contains a nested object)" do
        let(:input) { load_json_fixture("valid_ncco_with_connect_action.json") }

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
              "The 1st action is invalid: text is missing",
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

          context "with a 'connect' action (which contains a nested object)" do
            context "with an additional unrecognised attribute" do
              let(:input) do
                load_json_fixture(
                  "invalid_ncco_with_invalid_connect_action_endpoint.json",
                )
              end

              it "raises an error" do
                expect { build }.to raise_error(
                  NCCO::InvalidActionError,
                  "The 1st action is invalid: endpoint has attributes which aren't " \
                  "part of the NCCO specification",
                )
              end
            end

            context "with an invalid attribute" do
              let(:input) do
                load_json_fixture("invalid_ncco_with_invalid_connect_action_endpoint_" \
                                  "attribute.json")
              end

              it "raises an error" do
                expect { build }.to raise_error(
                  NCCO::InvalidActionError,
                  "The 1st action is invalid: number must be a valid E.164-formatted " \
                  "phone number",
                )
              end
            end
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

  it "has a version number" do
    expect(NCCO::VERSION).to_not be nil
  end
end
