require 'spec_helper'

describe '/api/v1/conferences/*/slots' do
  before {
    @conference = FactoryGirl.create(:conference_with_3_slots)
    @schedule = @conference.schedule
    @stem = "/api/v1/conferences/#{@conference.conference_year}/slots"
    sign_in_as_a_admin_user
  }

  describe 'index' do
    it 'should return an array of slots for the conference' do
      get @stem
      expect(response.status).to eql(200)

      expect(json.length).to eql(3)
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

  describe 'update' do
    it 'should update the slot attributes and return the slot' do
      slot = @schedule.slots.first
      proposal = FactoryGirl.create(:proposal)

      attributes = {
        proposal_id: proposal.id,
        room_id: 1,
        code: 'abcd',
        comments: 'Might be running late from the airport'
      }

      patch "#{@stem}/#{slot.id}", attributes
      expect(response.status).to eql(200)
      expect(json["id"]).to eql(slot.id)
      slot.reload

      expect(slot.proposal_id).to eql(attributes[:proposal_id])
      expect(slot.room_id).to eql(attributes[:room_id])
      expect(slot.code).to eql(attributes[:code])
      expect(slot.comments).to eql(attributes[:comments])
    end

    it 'should return errors if the update fails' do
      slot = @schedule.slots.first
      patch "#{@stem}/#{slot.id}", {proposal_id: 'zz'}

      expect(response.status).to eql(422)
    end
  end
end