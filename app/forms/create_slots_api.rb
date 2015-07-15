class CreateSlotsApi
  include ActiveModel::Model

  attr_accessor :quantity, :start_time, :end_time, :schedule_id, :time_block_id, :label, :code

  validates :quantity, inclusion: { in: 1..50 }
  validates_datetime :start_time, allow_nil: true
  validates_datetime :end_time, allow_nil: true
  validate :schedule_or_time_block

  def persist!
    raise Exceptions::BadRequest.new(attributes) unless valid?
    slots = []
    ActiveRecord::Base.transaction do
      quantity.times { slots << create_slot }
    end
    slots
  end

  def attributes
    {
      quantity: quantity,
      start_time: start_time,
      end_time: end_time
    }
  end

  def quantity=(val)
    @quantity = val.present? ? val.to_i : val
  end

  private

  def create_slot
    Slot.create({
      time_block_id: find_or_create_time_block.id
    })
  end

  def find_or_create_time_block
    @time_block ||= time_block_id.present? ? TimeBlock.find(time_block_id) : TimeBlock.create!(time_block_params)
  end

  def time_block_params
    {
      schedule_id: schedule_id,
      start_time: start_time,
      end_time: end_time,
      label: label,
      code: code
    }
  end

  def schedule_or_time_block
    if time_block_id.present? && schedule_id.present?
      errors.add(:schedule_id, 'Cannot specify both the schedule id and the time slot id')
    elsif time_block_id.blank? && schedule_id.blank?
      errors.add(:schedule_id,'Must specify either the schedule id or the time slot id')
    end
  end
end