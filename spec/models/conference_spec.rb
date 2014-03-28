require 'spec_helper'

describe Conference do
  let (:active_conference) { FactoryGirl.build(:active_conference)}
  describe "validations" do

    it "active conference should be valid" do
      expect(active_conference).to be_valid
    end

    it "should not allow a tax rate > 1" do
      active_conference.tax_rate = 1.1
      expect(active_conference).to be_invalid
    end

    it "should not allow a tax rate < 0" do
      active_conference.tax_rate = -0.1
      expect(active_conference).to be_invalid
    end

  end

  it "should have 6 proposals" do
    active_conference.stubs(:proposals).returns(stub(count: 6))
    expect(active_conference.proposal_count).to eql(6)
  end

  it "should have 6 line items" do
    active_conference.stubs(:line_items).returns(stub(count: 6))
    expect(active_conference.registration_count).to eql(6)
  end

  describe "registration_breakdown" do
    before {
      active_conference.stubs(:conference_items).returns([
        stub(name: 'Conference', number_of_paid_registrants: 5),
        stub(name: 'Pre Conference', number_of_paid_registrants: 2),
        stub(name: 'Gala', number_of_paid_registrants: 1)
      ])
    }

    it "report should have 3 items" do
      expect(active_conference.registration_breakdown.count).to eql(3)
    end

    it "conference should have 6 paid registrants" do
      report = active_conference.registration_breakdown
      expect(report[0][0]).to eql('Conference')
      expect(report[0][1]).to eql(5)
    end

  end

  describe "enforcing one active conference" do
    it "should de-activate an old conference for a new conference" do
      c1 = Conference.create({tax_rate: 0.1, conference_year: 2013, active: true})
      c2 = Conference.create({tax_rate: 0.1, conference_year: 2014, active: true})
      expect(Conference.find(c1).active).to be_false
    end

    it "should force activate a conference when there is no active conference" do
      c1 = Conference.create({tax_rate: 0.1, conference_year: 2013, active: false})
      expect(c1.active).to be_true
    end

  end
end
