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
    context 'with rooms but no time blocks' do
      let!(:conference) { create(:conference_with_rooms, num_rooms: 3, num_time_blocks: 0) }

      it 'should create a slot for each room + time block combo' do
        expect {
          time_block = conference.schedule.time_blocks.create({start_time: Time.now, end_time: Time.now})
        }.to change{ conference.slots.count }.by(3)
      end
    end

    context 'conference without rooms' do
      let!(:conference) { create(:conference) }

      it 'should create 0 slots' do
        time_block = nil
        expect {
          conference.schedule.time_blocks.create({start_time: Time.now, end_time: Time.now})
        }.to_not change{ Slot.count }
      end
    end

    context 'conference with time blocks and rooms' do
      let!(:conference) { create(:conference_with_slots) }

      it 'should destroy the time blocks slots when a time block is destroyed' do
        conference.reload
        expect{
          conference.schedule.time_blocks.first.destroy!
        }.to change{ Slot.count }.by(-3)
      end
    end
  end
end
