require 'spec_helper'

describe Day do
  describe "valiations" do
    let(:day) { FactoryGirl.build(:day) }

    it "should be valid" do
      expect(day).to be_valid
    end

    it "should be invalid without label" do
      day.label = nil
      expect(day).to be_invalid
    end

    it "should be invalid without day_date" do
      day.day_date = nil
      expect(day).to be_invalid
    end
  end
end
