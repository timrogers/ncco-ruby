# frozen_string_literal: true

RSpec.describe NCCO::Schemas::Record do
  describe "action" do
    it { is_expected.to require_attribute(:action) }
    it { is_expected.to allow_value("record").for(:action) }
    it { is_expected.to_not allow_value("something else").for(:action) }
    it { is_expected.to_not allow_blank_values.for(:action) }
  end

  describe "format" do
    it { is_expected.to_not require_attribute(:format) }
    it { is_expected.to allow_value("mp3").for(:format) }
    it { is_expected.to allow_value("ogg").for(:format) }
    it { is_expected.to allow_value("wav").for(:format) }
    it { is_expected.to_not allow_value("something else").for(:format) }
    it { is_expected.to_not allow_blank_values.for(:format) }
  end

  describe "split" do
    it { is_expected.to_not require_attribute(:split) }
    it { is_expected.to allow_value("conversation").for(:split) }
    it { is_expected.to_not allow_value("something else").for(:split) }
    it { is_expected.to_not allow_blank_values.for(:split) }
  end

  describe "channels" do
    it { is_expected.to_not require_attribute(:channels) }
    it { is_expected.to allow_value(1).for(:channels) }
    it { is_expected.to allow_value(16).for(:channels) }
    it { is_expected.to allow_value(32).for(:channels) }
    it { is_expected.to_not allow_value(-1).for(:channels) }
    it { is_expected.to_not allow_value(9.9).for(:channels) }
    it { is_expected.to_not allow_value(33).for(:channels) }
    it { is_expected.to_not allow_blank_values.for(:channels) }
  end

  describe "endOnSilence" do
    it { is_expected.to_not require_attribute(:endOnSilence) }
    it { is_expected.to allow_value(3).for(:endOnSilence) }
    it { is_expected.to allow_value(6).for(:endOnSilence) }
    it { is_expected.to allow_value(10).for(:endOnSilence) }
    it { is_expected.to_not allow_value(2).for(:endOnSilence) }
    it { is_expected.to_not allow_value(11).for(:endOnSilence) }
    it { is_expected.to_not allow_value(4.5).for(:endOnSilence) }
    it { is_expected.to_not allow_value("something else").for(:endOnSilence) }
    it { is_expected.to_not allow_value("4").for(:endOnSilence) }
    it { is_expected.to_not allow_blank_values.for(:endOnSilence) }
  end

  describe "endOnKey" do
    it { is_expected.to_not require_attribute(:endOnKey) }

    (0..9).map(&:to_s).each do |digit|
      it { is_expected.to allow_value(digit).for(:endOnKey) }
    end

    it { is_expected.to allow_value("*").for(:endOnKey) }
    it { is_expected.to allow_value("#").for(:endOnKey) }
    it { is_expected.to_not allow_value(".").for(:endOnKey) }
    it { is_expected.to_not allow_value(1).for(:endOnKey) }
    it { is_expected.to_not allow_blank_values.for(:endOnKey) }
  end

  describe "beepStart" do
    it { is_expected.to_not require_attribute(:beepStart) }
    it { is_expected.to allow_value(true).for(:beepStart) }
    it { is_expected.to allow_value(false).for(:beepStart) }
    it { is_expected.to_not allow_value("true").for(:beepStart) }
    it { is_expected.to_not allow_blank_values.for(:beepStart) }
  end

  describe "timeout" do
    it { is_expected.to_not require_attribute(:timeout) }
    it { is_expected.to allow_value(3).for(:timeout) }
    it { is_expected.to allow_value(1000).for(:timeout) }
    it { is_expected.to allow_value(7200).for(:timeout) }
    it { is_expected.to_not allow_value(7201).for(:timeout) }
    it { is_expected.to_not allow_value(2).for(:timeout) }
    it { is_expected.to_not allow_value(2.5).for(:timeout) }
    it { is_expected.to_not allow_blank_values.for(:timeout) }
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
