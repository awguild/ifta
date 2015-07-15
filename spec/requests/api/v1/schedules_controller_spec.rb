require 'spec_helper'

describe '/api/v1/conferences/*/schedule' do
  before {
    @conference = FactoryGirl.create(:conference_with_3_slots)
    @stem = "/api/v1/conferences/#{@conference.conference_year}"
    sign_in_as_a_admin_user
  }

  describe 'show' do
    it 'should return an array of time blocks with slots' do
      get "#{@stem}/schedule"
      expect(response.status).to eql(200)

      expect(json.length).to eql(1)
      expect(json[0]["slots"].length).to eql(3)
    end
  end
end