class Slot < ActiveRecord::Base
  #associations
  belongs_to :proposal
  belongs_to :room

  #validations
  validates :proposal, :existence => true, :unless => 'proposal_id.blank?'
  validates :proposal_id, :uniqueness => true, :unless => 'proposal_id.blank?'

end
