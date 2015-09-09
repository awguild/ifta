require 'spec_helper'

describe Proposal do
  context 'validations' do
    it 'should add have a relative number of 4 when there are 3 proposals' do
      conference = create(:conference_with_proposals)
      proposal = build(:proposal, conference: conference)
      proposal.save
      expect(proposal.relative_number).to eql(4)
    end

    it 'should have a relative number of 1 when other proposals are different conference' do
      conference = create(:conference_with_proposals)
      proposal = create(:proposal)
      expect(proposal.relative_number).to eql(1)
    end
  end

  context :accepted_and_unregistered do
    it 'should not include proposals that are rejected' do
      proposal = create(:proposal, :rejected)
      presenter = create(:presenter, proposal: proposal)

      report = Proposal.accepted_and_unregistered(proposal.conference)
      expect(report[proposal.id]).to be_blank
    end

    it 'should include proposals that are accepted' do
      proposal = create(:proposal, :accepted)
      presenter = create(:presenter, proposal: proposal)

      report = Proposal.accepted_and_unregistered(proposal.conference)
      expect(report[proposal.id]).to be_present
    end

    it 'should not include proposals from other conferences' do
      proposal = create(:proposal, :accepted)
      conference = create(:conference)

      report = Proposal.accepted_and_unregistered(conference)
      expect(report[proposal.id]).to be_blank
    end
  end

  context :add_self_as_presenter do
    it 'should add a presenter' do
      proposal = build(:proposal)
      proposal.add_self_as_presenter

      expect{
        proposal.save
      }.to change { proposal.presenters.count }.by(1)
    end

    it 'persenter should be the user' do
      proposal = build(:proposal)
      proposal.add_self_as_presenter

      expect{
        proposal.save
      }.to change { Presenter.where(email: proposal.user.email).count }.by(1)
    end
  end
end
