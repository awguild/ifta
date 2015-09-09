require 'spec_helper'

describe '/api/v1/conferences/*/proposals' do
  before {
    @conference = create(:conference_with_proposals)
    @stem = "/api/v1/conferences/#{@conference.conference_year}/proposals"
    sign_in_as_a_admin_user
  }

  describe 'search' do
    it 'should return an empty array if proposals are not accepted' do
      get "#{@stem}/search"
      expect(response.status).to eql(200)

      expect(json.length).to eql(0)
    end

    it 'should return an accepted proposal' do
      @proposal = create(:proposal, :accepted)
      conference = @proposal.conference
      get "/api/v1/conferences/#{conference.conference_year}/proposals/search"
      expect(response.status).to eql(200)

      expect(json.length).to eql(1)
    end

    it 'should not return an unaccepted proposal' do
      @proposal = create(:proposal, :rejected)
      conference = @proposal.conference
      get "/api/v1/conferences/#{conference.conference_year}/proposals/search"
      expect(response.status).to eql(200)

      expect(json.length).to eql(0)
    end

    it 'should not return a slotted proposal' do
      @proposal = create(:slotted_proposal)
      conference = @proposal.conference
      get "/api/v1/conferences/#{conference.conference_year}/proposals/search"
      expect(response.status).to eql(200)

      expect(json.length).to eql(0)
    end
  end

  # TODO figure out how to share the db transaction
  # describe 'presenters' do
  #   it 'should return a presenter with slotted count 0 and listed count of 1' do
  #     @proposal = create(:accepted_proposal_with_presenter)
  #     conference = @proposal.conference
  #     get "/api/v1/conferences/#{conference.conference_year}/proposals/presenters"

  #     expect(response.status).to eql(200)
  #     expect(json.length).to eql(1)
  #     expect(json[0]["listed_count"]).to eql(1)
  #     expect(json[0]["slotted_count"]).to eql(0)
  #   end

  #   it 'should return a presenter with slotted count of 1 and listed count of 1' do
  #     @proposal = create(:slotted_proposal_with_presenter)
  #     conference = @proposal.conference
  #     get "/api/v1/conferences/#{conference.conference_year}/proposals/presenters"

  #     expect(response.status).to eql(200)
  #     expect(json.length).to eql(1)
  #     expect(json[0]["listed_count"]).to eql(1)
  #     expect(json[0]["slotted_count"]).to eql(1)
  #   end
  # end

  describe 'formats' do
    it 'should return the distinct proposal formats' do
      @proposal = create(:proposal, :fortyfivemin)
      conference = @proposal.conference
      get "/api/v1/conferences/#{conference.conference_year}/proposals/formats"
      expect(json.length).to eql(1)
      expect(json[0]).to eql(@proposal.format)
    end
  end
end
