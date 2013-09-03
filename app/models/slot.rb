class Slot < ActiveRecord::Base
  attr_accessible :comments, :code, :proposal_id, :room_id, :time_slot_id
  
  belongs_to :time_slot
  belongs_to :proposal
  belongs_to :room
  validates :proposal, :existence => true, :unless => 'proposal_id.blank?'
  validates :time_slot, :existence => true, :unless => 'time_slot_id.blank?'
  validates :proposal_id, :uniqueness => true, :unless => 'proposal_id.blank?'

end
