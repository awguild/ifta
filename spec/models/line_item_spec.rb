require 'spec_helper'

describe LineItem do
  describe 'total_price' do
    let(:line_item1) { LineItem.new(price: 10) }
    let(:line_item2) { LineItem.new(price: 20) }

    it 'should sum the price of many line items' do
      expect(LineItem.total_price([line_item1, line_item2])).to eql(30)
    end

    it 'should return zero when there are no line items' do
      expect(LineItem.total_price([])).to eql(0)
    end
  end

  describe 'validations' do
    it 'should return false if the itinerary is missing' do
      line_item = LineItem.new
      expect(line_item).to be_invalid
    end

    it 'should return false if the conference_item is missing' do
      line_item = LineItem.new
      expect(line_item).to be_invalid
    end
  end
end
