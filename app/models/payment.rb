class Payment < ActiveRecord::Base
  attr_accessible :transaction_id, :amount, :params, :confirmed
  belongs_to :transaction
  serialize :params
  
  after_save :mark_transaction
  
  
  def mark_transaction
      transaction.paid = confirmed
      transaction.save
  end
end
