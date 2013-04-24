class Payment < ActiveRecord::Base
  attr_accessible :transaction_id, :amount, :params, :confirmed, :comments
  belongs_to :transaction
  delegate :user, :to => :transaction
  serialize :params
  
  after_save :mark_transaction
  before_destroy :clear_transaction
  
  def mark_transaction
      transaction.paid = confirmed
      transaction.save
  end
  
  def clear_transaction
    transaction.paid = false
    transaction.save
  end
end
