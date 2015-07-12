require 'spec_helper'

describe '/api/v1/conferences/*/slots' do
  before {
    @conference = FactoryGirl.create(:conference)
    @schedule = @conference.schedule
    @stem = "/api/v1/conferences/#{@conference.conference_year}/slots"
    sign_in_as_a_admin_user
  }

  describe 'index' do
    it 'should return an array of slots for the conference' do
      slot = @schedule.slots.create!
      get @stem
      expect(response.status).to eql(200)

      expect(json.length).to eql(1)
      expect(json[0]["id"]).to eql(slot.id)
    end
  end

  describe 'create' do
    it 'should create 4 slots for the schedule and return them in the response body' do
      expect {
        post @stem, {
          quantity: 4,
          start_time: Time.now,
          end_time: 1.hour.from_now
        }
      }.to change { @conference.schedule.slots.count }.by(4)

      expect(response.status).to eql(201)
      expect(json.length).to eql(4)
    end

    it 'should return 422 when no quantity is set' do
      expect {
        post @stem, {}
      }.to_not change { @conference.schedule.slots.count }

      expect(response.status).to eql(422)
    end
  end
end