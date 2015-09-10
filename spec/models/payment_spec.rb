require 'spec_helper'

describe Payment do
  context 'mark_transaction on save' do
    it 'unconfirmed payment sets order paid to false' do
      order = build(:order, paid: true)
      payment = build(:payment, :unconfirmed, order: order)

      payment.save
      expect(payment.order.paid).to be_falsey
    end

    it 'confirming the payment should set order paid' do
      order = build(:order, paid: false)
      payment = build(:payment, :confirmed, order: order)

      payment.save
      expect(payment.order.paid).to be_truthy
    end
  end

  context 'clear_transaction on destroy' do
    let(:payment) { create(:payment, :confirmed, order: create(:order)) }

    it 'should set the order paid flag to false on destroy' do
      payment.destroy
      payment.order.reload
      expect(payment.order.paid).to be_falsey
    end
  end
end
