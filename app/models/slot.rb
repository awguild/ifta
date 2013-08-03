class Slot < ActiveRecord::Base
  attr_accessible :comments, :code
  
  belongs_to :time_slot
  belongs_to :proposal
  belongs_to :room
end
