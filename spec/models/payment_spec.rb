require 'spec_helper'

describe Payment do
  context 'mark_transaction on save' do
    it 'should set transaction paid to false' do
      payment = FactoryGirl.build(:unconfirmed_payment)
      transaction = payment.transaction
      transaction.paid = true

      transaction.expects(:save)
      payment.save
      expect(transaction.paid).to be_false
    end

    it 'should set transaction paid to true' do
      payment = FactoryGirl.build(:confirmed_payment)
      transaction = payment.transaction
      transaction.paid = false

      transaction.expects(:save)
      payment.save
      expect(transaction.paid).to be_true
    end

  end

  context 'clear_transaction on destroy' do
    it 'should set the transaction paid flag to false on destroy' do
      payment = FactoryGirl.build(:payment)
      transaction = payment.transaction
      transaction.paid = true

      transaction.expects(:save)
      payment.destroy
      expect(transaction.paid).to be_false
    end
  end
end