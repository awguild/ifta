require 'spec_helper'

describe Itinerary do


  context :available_conference_items do
    it 'should be blank when there are no discounted items or regular items' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: []))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [])))
      itinerary = build(:itinerary)
      expect(itinerary.available_conference_items).to be_blank
    end

    it 'should have one item when discounted items has one item and regular is blank' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: [{}]))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [])))
      itinerary = build(:itinerary)
      expect(itinerary.available_conference_items.length).to eql(1)
    end

    it 'should have one item when discounted items is blank and regular has one item' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: []))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [{}])))
      itinerary = build(:itinerary)
      expect(itinerary.available_conference_items.length).to eql(1)
    end

    it 'should have 3 items when discounted items has 2 and regular has 1' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: [{}, {}]))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [{}])))
      itinerary = build(:itinerary)
      expect(itinerary.available_conference_items.length).to eql(3)
    end
  end

  context :any_items? do
    it 'should not have any items when discounted is blank and regular is blank' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: []))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [])))
      itinerary = build(:itinerary)
      expect(itinerary.any_items?).to be_falsey
    end

    it 'should have items when it has discounted items' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: [{}]))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [])))
      itinerary = build(:itinerary)
      expect(itinerary.any_items?).to be_truthy
    end

    it 'should have items when it has regular items' do
      ConferenceItem.stubs(:discounted_items).returns(stub(not_registered: []))
      ConferenceItem.stubs(:regular_priced_items).returns(stub(not_registered: stub(not_discounted: [{}])))
      itinerary = build(:itinerary)
      expect(itinerary.any_items?).to be_truthy
    end
  end

  context :line_items_pre_tax_price do
    it 'should invoke LineItem#total_price with unpaid line items' do
      itinerary = build(:itinerary)
      line_items = [{}, {}]
      itinerary.stubs(:line_items).returns(stub(where: line_items))
      LineItem.expects(:total_price).with(line_items)
      itinerary.line_items_pre_tax_price
    end
  end

  context :line_items_tax_price do
    it 'tax price should be 3 dollars' do
      itinerary = build(:itinerary)
      itinerary.stubs(:line_items_pre_tax_price).returns(10)
      Conference.stubs(active: stub(tax_rate: 0.3))
      expect(itinerary.line_items_tax_price).to eql(3.0)
    end
  end

  context :registered_for_conference? do
    it 'should be false when itinerary has no line items' do
      itinerary = build(:itinerary)
      expect(itinerary.registered_for_conference?).to be_falsey
    end
  end

  context :has_pending_conference_registration? do
    it 'should be false when itinerary has no line items' do
      itinerary = build(:itinerary)
      expect(itinerary.has_pending_conference_registration?).to be_falsey
    end
  end
end
