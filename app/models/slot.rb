class Slot < ActiveRecord::Base
  #associations
  belongs_to :proposal
  belongs_to :room

  #validations
  validates :proposal, :existence => true, :if => :proposal_id?
  validates :proposal_id, :uniqueness => true, :if => :proposal_id?

end
