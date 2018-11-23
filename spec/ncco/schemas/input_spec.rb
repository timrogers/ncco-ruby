# frozen_string_literal: true

RSpec.describe NCCO::Schemas::Input do
  describe "action" do
    it { is_expected.to require_attribute(:action) }
    it { is_expected.to allow_value("input").for(:action) }
    it { is_expected.to_not allow_value("something else").for(:action) }
    it { is_expected.to_not allow_blank_values.for(:action) }
  end

  describe "timeOut" do
    it { is_expected.to_not require_attribute(:timeOut) }
    it { is_expected.to allow_value(1).for(:timeOut) }
    it { is_expected.to allow_value(10).for(:timeOut) }
    it { is_expected.to_not allow_value(11).for(:timeOut) }
    it { is_expected.to_not allow_value(0).for(:timeOut) }
    it { is_expected.to_not allow_value(2.5).for(:timeOut) }
    it { is_expected.to_not allow_blank_values.for(:timeOut) }
  end

  describe "maxDigits" do
    it { is_expected.to_not require_attribute(:maxDigits) }
    it { is_expected.to allow_value(1).for(:maxDigits) }
    it { is_expected.to allow_value(20).for(:maxDigits) }
    it { is_expected.to_not allow_value(21).for(:maxDigits) }
    it { is_expected.to_not allow_value(0).for(:maxDigits) }
    it { is_expected.to_not allow_value(2.5).for(:maxDigits) }
    it { is_expected.to_not allow_blank_values.for(:maxDigits) }
  end

  describe "submitOnHash" do
    it { is_expected.to_not require_attribute(:submitOnHash) }
    it { is_expected.to allow_value(true).for(:submitOnHash) }
    it { is_expected.to allow_value(false).for(:submitOnHash) }
    it { is_expected.to_not allow_value("true").for(:submitOnHash) }
    it { is_expected.to_not allow_blank_values.for(:submitOnHash) }
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
end
