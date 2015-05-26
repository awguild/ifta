require 'spec_helper'

describe '/api/v1/conferences/*/schedules' do
  before {
    @schedule = FactoryGirl.create(:schedule)
    @conference = @schedule.conference
    @stem = "/api/v1/conferences/#{@conference.conference_year}"
    sign_in_as_a_admin_user
  }

  # todo need to refactor days, time slots, and slots
end