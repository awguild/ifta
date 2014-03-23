class Review < ActiveRecord::Base
  attr_accessible :proposal_id, :status, :comments, :reviewer_id
  belongs_to :proposal
  belongs_to :reviewer, :class_name => 'User'

  after_save :set_proposal #Since IFTA only uses one review we can immediately set the status of the proposal

  private

  def set_proposal
    proposal.status = status
    proposal.save
  end

end
