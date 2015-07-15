require 'spec_helper'

describe '/api/v1/conferences/*/time_blocks' do

  before {
    @conference = FactoryGirl.create(:conference_with_3_rooms)
    @stem = "/api/v1/conferences/#{@conference.conference_year}"
    sign_in_as_a_admin_user
  }


  describe 'create' do
    it 'should create a slots for each room and return them in the response body' do
      expect {
        post "#{@stem}/time_blocks", {
          start_time: Time.now,
          end_time: 1.hour.from_now
        }
      }.to change { @conference.schedule.time_blocks.count }.by(1)

      expect(response.status).to eql(201)
      expect(json["slots"].length).to eql(3)
    end

    it 'should return 422 when no start_time is set' do
      expect {
        post "#{@stem}/time_blocks", {end_time: Time.now}
      }.to_not change { @conference.schedule.slots.count }

      expect(response.status).to eql(422)
    end
  end
end