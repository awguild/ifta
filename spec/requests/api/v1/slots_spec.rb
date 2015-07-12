require 'spec_helper'

describe '/api/v1/conferences/*/slots' do
  before {
    @conference = FactoryGirl.create(:conference_with_3_slots)
    @schedule = @conference.schedule
    @stem = "/api/v1/conferences/#{@conference.conference_year}/slots"
    sign_in_as_a_admin_user
  }

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