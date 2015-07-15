require 'spec_helper'

describe '/api/v1/conferences/*/time_blocks' do
  before {
    @conference = FactoryGirl.create(:conference_with_3_rooms)
    @stem = "/api/v1/conferences/#{@conference.conference_year}"
    sign_in_as_a_admin_user
  }

  describe 'index' do
    it 'should return an array of time blocks with slots' do
      get "#{@stem}/time_blocks"
      expect(response.status).to eql(200)

      expect(json.length).to eql(1)
      expect(json[0]["slots"].length).to eql(3)
    end
  end


  describe 'create' do
    it 'should create a slot for each room and return them in the response body' do
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

  describe 'update' do
    it 'should update the time block code' do
      time_block = @conference.schedule.time_blocks.create({
        start_time: Time.now,
        end_time: Time.now,
        code: 'abcd'
      })

      put "#{@stem}/time_blocks/#{time_block.id}", {
        code: 'xyz'
      }
      expect(response.status).to eql(204)
      time_block.reload
      expect(time_block.code).to eql('xyz')
    end
  end

  describe 'destroy' do
    it 'should remove a time_block' do
      time_block = @conference.schedule.time_blocks.create({
        start_time: Time.now,
        end_time: Time.now
      })

      expect {
        delete "#{@stem}/time_blocks/#{time_block.id}"
      }.to change{TimeBlock.count}.by(-1)
      expect(response.status).to eql(204)
    end
  end
end