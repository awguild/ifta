class CreateSlotsApi
  include ActiveModel::Model

  attr_accessor :quantity, :start_time, :end_time

  validates :quantity, inclusion: { in: 1..50 }
  validates_datetime :start_time, allow_nil: true
  validates_datetime :end_time, allow_nil: true


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
      start_time: start_time,
      end_time: end_time
    })
  end
end