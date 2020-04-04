require 'spec_helper'

describe Conference do
  context 'registration_breakdown' do
    before {
      subject.stubs(:conference_items).returns([
        stub(name: 'Conference', number_of_paid_registrants: 5),
        stub(name: 'Pre Conference', number_of_paid_registrants: 2),
        stub(name: 'Gala', number_of_paid_registrants: 1)
      ])
    }

    it 'report should have 3 items' do
      expect(subject.registration_breakdown.count).to eql(3)
    end

    it 'conference should have 6 paid registrants' do
      report = subject.registration_breakdown
      expect(report[0][:name]).to eql('Conference')
      expect(report[0][:registrant_count]).to eql(5)
    end

  end

  context 'enforcing one active conference' do
    it 'should de-activate an old conference for a new conference' do
      c1 = Conference.create({tax_rate: 0.1, conference_year: 2013, active: true})
      c2 = Conference.create({tax_rate: 0.1, conference_year: 2014, active: true})
      expect(Conference.find(c1.id).active).to be_falsey
    end

    it 'should force activate a conference when there is no active conference' do
      c1 = Conference.create({tax_rate: 0.1, conference_year: 2013, active: false})
      expect(c1.active).to be_truthy
    end

  end

  context 'to_param' do
    it 'should return a conference_year' do
      conference = build(:conference)
      conference.conference_year = 2014
      expect(conference.to_param).to eql('2014')
    end
  end
end
