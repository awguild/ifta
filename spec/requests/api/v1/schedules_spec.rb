require 'spec_helper'

describe '/api/v1/conferences/*/schedules' do
  before {
    @conference = FactoryGirl.create(:conference)
    @schedule = @conference.schedule
    @stem = "/api/v1/conferences/#{@conference.conference_year}/schedule"
    sign_in_as_a_admin_user
  }

  it 'should return the slots for the schedule' do
    slot = @schedule.slots.create!
    get @stem
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json.length).to eql(1)
  end
end