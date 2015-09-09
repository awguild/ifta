require 'spec_helper'

describe Room do
  context 'validations' do
    it 'should be invalid without a schedule' do
      room = Room.new
      expect(room).to be_invalid
    end

    it 'should be valid if it has a schedule' do
      conference = create(:conference)
      room = conference.schedule.rooms.build
      expect(room).to be_valid
    end
  end

  context 'managing slots' do
    it 'should create a slot for each time block when creating a room' do
      conference = create(:conference)

      3.times do
        conference.schedule.time_blocks.create!({start_time: Time.now, end_time: Time.now})
      end

      room = nil
      expect {
        room = conference.schedule.rooms.create!
      }.to change{Slot.count}.by(3)

      conference.schedule.time_blocks.each do |time_block|
        expect(time_block.slots.count).to eql(1)
      end

      expect(room.slots.count).to eql(3)
    end

    it 'should create 0 slots when creating a room for a conference without time blocks' do
      conference = create(:conference)

      room = nil
      expect {
        conference.schedule.rooms.create!
      }.to_not change{Slot.count}
    end

    it 'should destroy the rooms slots when a room is destroyed' do
      conference = create(:conference_with_rooms)

      expect{
        conference.schedule.rooms.first.destroy!
      }.to change{Slot.count}.by(-1)
    end
  end
end
