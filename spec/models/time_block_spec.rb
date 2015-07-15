require 'spec_helper'

describe TimeBlock do
  context 'validations' do
    it 'should be invalid without a start or end time' do
      time_block = TimeBlock.new
      expect(time_block).to be_invalid
    end

    it 'should not be valid if the start time is the wrong format' do
      time_block = TimeBlock.new({start_time: 'a8aa', end_time: Time.now})
      expect(time_block).to be_invalid
    end

    it 'should not be valid if the end time is the wrong format' do
      time_block = TimeBlock.new({start_time: Time.now, end_time: 'aa5a'})
      expect(time_block).to be_invalid
    end

    it 'should be valid if the end time and end time are in the right format' do
      time_block = TimeBlock.new({start_time: Time.now, end_time: Time.now})
      expect(time_block).to be_valid
    end
  end

  context 'managing slots' do
    it 'should create a slot for each room when creating a time block' do
      conference = FactoryGirl.create(:conference)

      3.times do
        conference.schedule.rooms.create!
      end

      time_block = nil
      expect {
        time_block = conference.schedule.time_blocks.create({start_time: Time.now, end_time: Time.now})
      }.to change{Slot.count}.by(3)

      conference.schedule.rooms.each do |room|
        expect(room.slots.count).to eql(1)
      end

      expect(time_block.slots.count).to eql(3)
    end

    it 'should create 0 slots when creating a time block for a conference without rooms' do
      conference = FactoryGirl.create(:conference)

      time_block = nil
      expect {
        conference.schedule.time_blocks.create({start_time: Time.now, end_time: Time.now})
      }.to_not change{Slot.count}
    end

    it 'should destroy the time blocks slots when a time block is destroyed' do
      conference = FactoryGirl.create(:conference_with_3_slots)

      expect{
        conference.schedule.time_blocks.first.destroy!
      }.to change{Slot.count}.by(-3)
    end
  end
end