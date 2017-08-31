class Review < ActiveRecord::Base
  #associations
  belongs_to :proposal
  belongs_to :reviewer, :class_name => 'User'

  #life cycle hooks
  after_save :set_proposal #Since IFTA only uses one review we can immediately set the status of the proposal

  def accepted?
    status == 'accept'
  end

  def declined?
    status == 'decline'
  end

  def drop_out?
    status == 'drop out'
  end

  private

  def set_proposal
    proposal.status = status
    proposal.save
  end

end
