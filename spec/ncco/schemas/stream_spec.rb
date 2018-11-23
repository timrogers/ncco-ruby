# frozen_string_literal: true

RSpec.describe NCCO::Schemas::Stream do
  describe "action" do
    it { is_expected.to require_attribute(:action) }
    it { is_expected.to allow_value("stream").for(:action) }
    it { is_expected.to_not allow_value("something else").for(:action) }
    it { is_expected.to_not allow_blank_values.for(:action) }
  end

  describe "streamUrl" do
    it { is_expected.to require_attribute(:streamUrl) }
    it { is_expected.to allow_value("http://foo.bar").for(:streamUrl) }
    it { is_expected.to allow_value("https://foo.bar").for(:streamUrl) }
    it { is_expected.to_not allow_value("foo").for(:streamUrl) }
    it { is_expected.to_not allow_value("ftp://foo.bar").for(:streamUrl) }
    it { is_expected.to_not allow_blank_values.for(:streamUrl) }
  end

  describe "bargeIn" do
    it { is_expected.to_not require_attribute(:bargeIn) }
    it { is_expected.to allow_value(true).for(:bargeIn) }
    it { is_expected.to allow_value(false).for(:bargeIn) }
    it { is_expected.to_not allow_value("true").for(:bargeIn) }
    it { is_expected.to_not allow_blank_values.for(:bargeIn) }
  end

  describe "loop" do
    it { is_expected.to_not require_attribute(:loop) }
    it { is_expected.to allow_value(5).for(:loop) }
    it { is_expected.to_not allow_value("forever").for(:loop) }
    it { is_expected.to_not allow_value(1.2).for(:loop) }
    it { is_expected.to_not allow_blank_values.for(:loop) }
  end

  describe "level" do
    it { is_expected.to_not require_attribute(:level) }
    it { is_expected.to allow_value(-1).for(:level) }
    it { is_expected.to allow_value(0).for(:level) }
    it { is_expected.to allow_value(1).for(:level) }
    it { is_expected.to_not allow_value(1.2).for(:level) }
    it { is_expected.to_not allow_value("something else").for(:level) }
    it { is_expected.to_not allow_blank_values.for(:level) }
  end
end
