# frozen_string_literal: true

RSpec.describe NCCO::Schemas::Talk do
  describe "action" do
    it { is_expected.to require_attribute(:action) }
    it { is_expected.to allow_value("talk").for(:action) }
    it { is_expected.to_not allow_value("something else").for(:action) }
    it { is_expected.to_not allow_blank_values.for(:action) }
  end

  describe "text" do
    it { is_expected.to require_attribute(:text) }
    it { is_expected.to allow_value("Hello!").for(:text) }
    it { is_expected.to_not allow_value(not_a: "string").for(:text) }
    it { is_expected.to_not allow_blank_values.for(:text) }
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

  describe "voiceName" do
    it { is_expected.to_not require_attribute(:voiceName) }
    it { is_expected.to allow_value("string").for(:voiceName) }
    it { is_expected.to_not allow_blank_values.for(:voiceName) }
  end
end
