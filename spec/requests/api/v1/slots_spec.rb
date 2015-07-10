require 'spec_helper'

describe '/api/v1/conferences/*/slots' do
  before {
    @conference = FactoryGirl.create(:conference)
    @schedule = @conference.schedule
    @stem = "/api/v1/conferences/#{@conference.conference_year}/slots"
    sign_in_as_a_admin_user
  }

  it 'should return an array of slots for the conference' do
    slot = @schedule.slots.create!
    get @stem
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json.length).to eql(1)
    expect(json[0]["id"]).to eql(slot.id)
  end
end