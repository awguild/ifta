require 'spec_helper'

describe '/api/v1/conferences/*/rooms' do
  before {
    @room = FactoryGirl.create(:room)
    @conference = @room.conference
    @stem = "/api/v1/conferences/#{@conference.conference_year}"
    sign_in_as_a_admin_user
  }

  describe 'index' do
    it 'should return the rooms for a conference' do
      get "#{@stem}/rooms"

      expect(json.length).to eql(1)
      expect(json[0]["id"]).to eql(@room.id)
    end
  end

  describe 'create' do
    it 'should create a new room' do
      expect {
        post "#{@stem}/rooms", {
          label: 'Brown Room'
        }
      }.to change{Room.count}.by(1)

      expect(response.status).to eql(201)
    end

    it 'should raise error when conference does not exist' do
      expect {
        post "/api/v1/conferences/0000/rooms", {
          label: 'Brown Room'
        }
      }.to raise_error{ActiveRecord::RecordNotFound}
    end
  end


  describe 'update' do
    it 'should update the room label' do
      put "#{@stem}/rooms/#{@room.id}", {
        label: 'Green Room'
      }
      expect(response.status).to eql(204)
      @room.reload
      expect(@room.label).to eql('Green Room')
    end
  end

  describe 'destroy' do
    it 'should remove a room' do
      expect {
        delete "#{@stem}/rooms/#{@room.id}"
      }.to change{Room.count}.by(-1)
      expect(response.status).to eql(204)
    end
  end
end