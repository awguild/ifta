require 'spec_helper'

describe Discount do

  describe :validations do
    it 'should not allow two discounts with the same key' do
      discount = create(:discount)
      discount2 = build(:discount)
      discount2.discount_key = discount.discount_key
      expect(discount2).to be_invalid
    end

    it 'should have a discount key of length six' do
      discount = build(:discount)
      discount.discount_key = '123'
      expect(discount).to be_invalid
    end
  end

  describe :discount_key do
    it 'should generate a valid discount key on initialization' do
      discount = Discount.new
      expect(discount.discount_key.length).to eql(6)
    end
  end

  describe :build_prices_for_conference_items do
    it 'should return false when there is no conference' do
      discount = Discount.new
      expect(discount.build_prices_for_conference_items).to eql(false)
    end

    it 'should build a price for each conference item' do
      conference = create(:conference_with_items)
      discount = conference.discounts.build

      discount.build_prices_for_conference_items

      expect(discount.prices.length).to eql(3)
    end
  end
end
