require 'spec_helper'

describe Proposal do
  context 'validations' do
    it 'should add relative numbering before validations' do
      proposal = FactoryGirl.build(:proposal)
      expect(proposal.relative_number).to be_blank
      proposal.valid?
      expect(proposal.relative_number).to eql(1)
    end

    it 'should add have a relative number of 4 when there are 3 proposals' do
      conference = FactoryGirl.create(:conference_with_3_proposals)
      proposal = FactoryGirl.build(:proposal, conference: conference)
      proposal.save
      expect(proposal.relative_number).to eql(4)
    end

    it 'should have a relative number of 1 when other proposals are different conference' do
      conference = FactoryGirl.create(:conference_with_3_proposals)
      proposal = FactoryGirl.create(:proposal)
      expect(proposal.relative_number).to eql(1)
    end
  end

  context :accepted_and_unregistered do
    it 'should not include proposals that are rejected' do
      proposal = FactoryGirl.create(:rejected_proposal_with_presenter)
      report = Proposal.accepted_and_unregistered(proposal.conference)
      expect(report[proposal.id]).to be_blank
    end

    it 'should include proposals that are accepted' do
      proposal = FactoryGirl.create(:accepted_proposal_with_presenter)
      report = Proposal.accepted_and_unregistered(proposal.conference)
      expect(report[proposal.id]).to be_present
    end

    it 'should not include proposals from other conferences' do
      proposal = FactoryGirl.create(:accepted_proposal_with_presenter)
      conference = FactoryGirl.create(:conference)
      report = Proposal.accepted_and_unregistered(conference)
      expect(report[proposal.id]).to be_blank
    end
  end

  context :add_self_as_presenter do
    it 'proposal should have user as presenter' do
      proposal = FactoryGirl.create(:proposal)
      user = FactoryGirl.create(:user)
      proposal.user = user

      proposal.add_self_as_presenter
      presenter = proposal.presenters[0]

      expect(presenter.first_name).to eql(user.first_name)
      expect(presenter.last_name).to eql(user.last_name)
      expect(presenter.email).to eql(user.email)
    end
  end
end