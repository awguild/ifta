require 'spec_helper'

describe Conference do
  let (:active_conference) { FactoryGirl.build(:active_conference)}
  context 'validations' do

    it 'active conference should be valid' do
      expect(active_conference).to be_valid
    end

    it 'should not allow a tax rate > 1' do
      active_conference.tax_rate = 1.1
      expect(active_conference).to be_invalid
    end

    it 'should not allow a tax rate < 0' do
      active_conference.tax_rate = -0.1
      expect(active_conference).to be_invalid
    end

  end

  context 'proposal_count' do
    it 'should have 6 proposals' do
      active_conference.stubs(:proposals).returns(stub(count: 6))
      expect(active_conference.proposal_count).to eql(6)
    end
  end

  context 'registration_count' do
    it 'should have 6 registered events' do
      active_conference.stubs(:line_items).returns(stub(where: stub(count: 6)))
      expect(active_conference.registration_count).to eql(6)
    end
  end

  context 'pending_registration_count' do
    it 'should have 6 pending events' do
      active_conference.stubs(:line_items).returns(stub(where: stub(count: 6)))
      expect(active_conference.pending_registration_count).to eql(6)
    end
  end

  context 'wait_listed_proposal_count' do
    it 'should have 1 wait listed proposal' do
      proposal = FactoryGirl.create(:wait_listed_proposal_with_presenter)
      conference = proposal.conference
      expect(conference.wait_listed_proposal_count).to eql(1)
    end
  end

  context 'accepted_proposal_count' do
    it 'should have 1 wait listed proposal' do
      proposal = FactoryGirl.create(:accepted_proposal_with_presenter)
      conference = proposal.conference
      expect(conference.accepted_proposal_count).to eql(1)
    end
  end

  context 'registration_breakdown' do
    before {
      active_conference.stubs(:conference_items).returns([
        stub(name: 'Conference', number_of_paid_registrants: 5),
        stub(name: 'Pre Conference', number_of_paid_registrants: 2),
        stub(name: 'Gala', number_of_paid_registrants: 1)
      ])
    }

    it 'report should have 3 items' do
      expect(active_conference.registration_breakdown.count).to eql(3)
    end

    it 'conference should have 6 paid registrants' do
      report = active_conference.registration_breakdown
      expect(report[0][:name]).to eql('Conference')
      expect(report[0][:registrant_count]).to eql(5)
    end

  end

  context 'enforcing one active conference' do
    it 'should de-activate an old conference for a new conference' do
      c1 = Conference.create({tax_rate: 0.1, conference_year: 2013, active: true})
      c2 = Conference.create({tax_rate: 0.1, conference_year: 2014, active: true})
      expect(Conference.find(c1).active).to be_falsey
    end

    it 'should force activate a conference when there is no active conference' do
      c1 = Conference.create({tax_rate: 0.1, conference_year: 2013, active: false})
      expect(c1.active).to be_truthy
    end

  end

  context 'to_param' do
    it 'should return a conference_year' do
      conference = FactoryGirl.build(:conference)
      conference.conference_year = 2014
      expect(conference.to_param).to eql(2014)
    end
  end
end
