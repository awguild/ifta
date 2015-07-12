require 'spec_helper'

describe '/api/v1/conferences/*/proposals' do
  before {
    @conference = FactoryGirl.create(:conference_with_3_proposals)
    @stem = "/api/v1/conferences/#{@conference.conference_year}/proposals"
    sign_in_as_a_admin_user
  }

  describe 'search' do
    it 'should return an array of proposals without a status' do
      get "#{@stem}/search"
      expect(response.status).to eql(200)

      expect(json.length).to eql(3)
    end

    it 'should return an accepted proposal when status=accept' do
      @proposal = FactoryGirl.create(:accepted_proposal_with_presenter)
      conference = @proposal.conference
      get "/api/v1/conferences/#{conference.conference_year}/proposals/search?status=accept"
      expect(response.status).to eql(200)

      expect(json.length).to eql(1)
    end

    it 'should not return an accepted proposal when status is not set' do
      @proposal = FactoryGirl.create(:accepted_proposal_with_presenter)
      conference = @proposal.conference
      get "/api/v1/conferences/#{conference.conference_year}/proposals/search"
      expect(response.status).to eql(200)

      expect(json.length).to eql(0)
    end
  end

  # TODO figure out how to share the db transaction
  # describe 'presenters' do
  #   it 'should return a presenter with accepted count and listed count of 1' do
  #     @proposal = FactoryGirl.create(:accepted_proposal_with_presenter)
  #     conference = @proposal.conference
  #     get "/api/v1/conferences/#{conference.conference_year}/proposals/presenters"

  #     expect(response.status).to eql(200)
  #     expect(json.length).to eql(1)
  #     expect(json[0]["listed_count"]).to eql(1)
  #     expect(json[0]["accepted_count"]).to eql(1)
  #   end

  #   it 'should return a presenter with accepted count of 0 and listed count of 1' do
  #     @proposal = FactoryGirl.create(:rejected_proposal_with_presenter)
  #     conference = @proposal.conference
  #     get "/api/v1/conferences/#{conference.conference_year}/proposals/presenters"

  #     expect(response.status).to eql(200)
  #     expect(json.length).to eql(1)
  #     expect(json[0]["listed_count"]).to eql(1)
  #     expect(json[0]["accepted_count"]).to eql(0)
  #   end
  # end
end