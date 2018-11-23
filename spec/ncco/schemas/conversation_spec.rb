# frozen_string_literal: true

RSpec.describe NCCO::Schemas::Conversation do
  describe "action" do
    it { is_expected.to require_attribute(:action) }
    it { is_expected.to allow_value("conversation").for(:action) }
    it { is_expected.to_not allow_value("something else").for(:action) }
    it { is_expected.to_not allow_blank_values.for(:action) }
  end

  describe "name" do
    it { is_expected.to require_attribute(:name) }
    it { is_expected.to allow_value("Hello!").for(:name) }
    it { is_expected.to_not allow_value(not_a: "string").for(:name) }
    it { is_expected.to_not allow_blank_values.for(:name) }
  end

  describe "musicOnHoldUrl" do
    it { is_expected.to_not require_attribute(:musicOnHoldUrl) }
    it { is_expected.to allow_value("http://foo.bar").for(:musicOnHoldUrl) }
    it { is_expected.to allow_value("https://foo.bar").for(:musicOnHoldUrl) }
    it { is_expected.to_not allow_value("foo").for(:musicOnHoldUrl) }
    it { is_expected.to_not allow_value("ftp://foo.bar").for(:musicOnHoldUrl) }
    it { is_expected.to_not allow_blank_values.for(:musicOnHoldUrl) }
  end

  describe "startOnEnter" do
    it { is_expected.to_not require_attribute(:startOnEnter) }
    it { is_expected.to allow_value(true).for(:startOnEnter) }
    it { is_expected.to allow_value(false).for(:startOnEnter) }
    it { is_expected.to_not allow_value("true").for(:startOnEnter) }
    it { is_expected.to_not allow_blank_values.for(:startOnEnter) }
  end

  describe "endOnExit" do
    it { is_expected.to_not require_attribute(:endOnExit) }
    it { is_expected.to allow_value(true).for(:endOnExit) }
    it { is_expected.to allow_value(false).for(:endOnExit) }
    it { is_expected.to_not allow_value("true").for(:endOnExit) }
    it { is_expected.to_not allow_blank_values.for(:endOnExit) }
  end

  describe "record" do
    it { is_expected.to_not require_attribute(:record) }
    it { is_expected.to allow_value(true).for(:record) }
    it { is_expected.to allow_value(false).for(:record) }
    it { is_expected.to_not allow_value("true").for(:record) }
    it { is_expected.to_not allow_blank_values.for(:record) }
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
