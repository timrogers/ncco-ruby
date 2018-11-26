# frozen_string_literal: true

RSpec.describe NCCO::Utils do
  describe ".deep_transform_keys" do
    subject(:transformed_hash) do
      described_class.deep_transform_keys(input, &:to_s)
    end

    let(:input) { { foo: :bar, baz: { bang: :bing } } }

    it { is_expected.to eq("foo" => :bar, "baz" => { "bang" => :bing }) }
  end

  describe ".deep_transform_keys_to_symbols" do
    subject(:transformed_hash) do
      described_class.
        deep_transform_keys_to_symbols(input, &:to_s)
    end

    let(:input) { { "foo" => :bar, "baz" => { "bang" => :bing } } }

    it { is_expected.to eq(foo: :bar, baz: { bang: :bing }) }
  end
end
