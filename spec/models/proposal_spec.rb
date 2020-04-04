require 'spec_helper'

describe Proposal do
  context 'validations' do
    it 'does not allow no equipment with other av options' do
      proposal = build(:proposal, sound: true, no_equipment: true)
      expect(proposal).to be_invalid
    end

    it 'does not allow av options with 20 min format' do
      proposal = build(:proposal, format: '20min', sound: true)
      expect(proposal).to be_invalid
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
    it 'persenter should be the user' do
      proposal = build(:proposal)
      presenter = proposal.add_self_as_presenter
      presenter.assign_attributes(
        highest_degree: "Phd",
        graduating_institution: "Augustana",
        qualifications: "Bootcamp"
      )

      expect{
        proposal.save
      }.to change { Presenter.where(email: proposal.user.email).count }.by(1)
    end
  end
end
