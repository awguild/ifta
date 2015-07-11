class Payment < ActiveRecord::Base
  #associations
  belongs_to :order, class_name: "Transaction", foreign_key: 'transaction_id' # rails 4 reserved transaction method, rename to order


  #life cycle hooks
  after_save :mark_transaction
  before_destroy :clear_transaction

  serialize :params
  delegate :user, :to => :transaction

  private

  def mark_transaction
    order.paid = confirmed
    order.save
  end

  def clear_transaction
    order.paid = false
    order.save
  end
end
