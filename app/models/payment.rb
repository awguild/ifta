class Payment < ActiveRecord::Base
  #associations
  belongs_to :transaction

  #life cycle hooks
  after_save :mark_transaction
  before_destroy :clear_transaction

  serialize :params
  delegate :user, :to => :transaction

  private

  def mark_transaction
      transaction.paid = confirmed
      transaction.save
  end

  def clear_transaction
    transaction.paid = false
    transaction.save
  end
end
