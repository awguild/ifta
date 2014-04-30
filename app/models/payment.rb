class Payment < ActiveRecord::Base
  attr_accessible :transaction_id, :amount, :params, :confirmed, :comments
  
  #associations
  belongs_to :transaction
  
  #life cycle hooks
  after_save :mark_transaction
  before_destroy :clear_transaction

  serialize :params
  delegate :user, :to => :transaction

  def mark_transaction
      transaction.paid = confirmed
      transaction.save
  end

  def clear_transaction
    transaction.paid = false
    transaction.save
  end
end
