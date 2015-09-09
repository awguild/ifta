require 'spec_helper'

describe LineItem do
  describe 'total_price' do
    let(:line_item1) { LineItem.new(price: 10) }
    let(:line_item2) { LineItem.new(price: 20) }

    it 'should sum the price of many line items' do
      expect(LineItem.total_price([line_item1, line_item2])).to eql(30)
    end

    it 'should return zero when there are no line items' do
      expect(LineItem.total_price([])).to eql(0.0)
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

    it 'should not allow price to differ from conference item price for user' do
      itinerary = create(:itinerary_with_item)
      line_item = itinerary.line_items.first

      line_item.price = 5
      line_item.conference_item.stubs(:item_price).returns(10)
      expect(line_item).to be_invalid
    end

    it 'should return true when the line item price matches the conference item price' do
      itinerary = create(:itinerary_with_item)
      line_item = itinerary.line_items.first

      line_item.price = 10
      line_item.conference_item.stubs(:item_price).returns(10)
      expect(line_item).to be_valid
    end
  end
end
