require 'spec_helper'

describe ConferenceItem do
  before {
    ConferenceItem.any_instance.stubs(:build_price_objects)
  }

  describe "current active" do
    before {
      FactoryGirl.create(:active_conference)
    }
    it "should show visible items from the current conference" do
      c = ConferenceItem.create!({visibility: true, conference_id: Conference.active.id})
      expect(ConferenceItem.current_active).to include(c)
    end

    it "should not show invisible items in current active" do
      c = ConferenceItem.create({visibility: false, conference_id: Conference.active.id})
      expect(ConferenceItem.current_active).not_to include(c)
    end

    it "should not show items from other conferences" do
      c = ConferenceItem.create({visibility: true, conference_id: 9999999})
      expect(ConferenceItem.current_active).not_to include(c)
    end
  end

  describe "filtering registered items and discounted items" do
    let!(:c1){ ConferenceItem.create }
    let!(:c2){ ConferenceItem.create }
    let!(:c3){ ConferenceItem.create }

    it "should exclude registered conference items 1 and 2" do
      line_items = [stub(conference_item_id: c1), stub(conference_item_id: c2)]

      expect(ConferenceItem.not_registered(line_items)).not_to include(c1, c2)
      expect(ConferenceItem.not_registered(line_items)).to include(c3)
    end

    it "should exclude discounted conference items 1 and 2" do
      discounted_items = [c1, c2]

      expect(ConferenceItem.not_discounted(discounted_items)).not_to include(c1, c2)
      expect(ConferenceItem.not_discounted(discounted_items)).to include(c3)
    end
  end

  describe "item price" do
    let!(:conference_item) { ConferenceItem.new }
    it "should have a price of 100" do
      conference_item.stubs(:price_for_user).returns(stub(amount: 100))
      expect(conference_item.item_price(stub, nil)).to eql(100)
    end

    it "should have a price of 50" do
      conference_item.stubs(:price_with_discount).returns(stub(amount: 50))
      expect(conference_item.item_price(stub, "123456")).to eql(50)
    end
  end
end
