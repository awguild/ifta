require 'spec_helper'

describe ConferenceItem do
  let(:conference) { create(:conference) }
  describe '#current_active' do
    it 'should find active items' do
      create(:conference_with_items, active_items: 2)
      expect(ConferenceItem.current_active.count).to eql(2)
    end

    it 'should not find invisible items' do
      create(:conference_with_items, active_items: 3, inactive_items: 1)
      expect(ConferenceItem.current_active.count).to eql(3)
    end

    it 'should not find active items from inactive conferences' do
      create(:conference_with_items, :inactive, active_items: 4)
      create(:conference_with_items, active_items: 2)
      expect(ConferenceItem.current_active.count).to eql(2)
    end
  end

  describe '#not_registered' do
    it 'should exclude conference items associated with registrations' do
      conference_item1 = create(:conference_item_with_registered_users, conference: conference)
      conference_item2 = create(:conference_item, conference: conference)

      expect(ConferenceItem.not_registered(conference_item1.line_items)).to match_array([conference_item2])
    end
  end

  describe '#not_discounted' do
    it 'should exclude conference items associated with discounts' do
      conference_item1 = create(:conference_item)
      conference_item2 = create(:conference_item)

      expect(ConferenceItem.not_discounted([conference_item1])).to match_array([conference_item2])
    end
  end

  describe '#item_price' do
    context 'no discount' do
      it 'should have a price of 200 for category 1 and 100 for category 2 member' do
        user1 = create(:user)
        member = create(:ifta_member)
        user2 = create(:user, :category2, ifta_member_email: member.email)

        conference_item = create(:conference_item)

        set_price(conference_item, user1, 200)
        set_price(conference_item, user2, 100)

        expect(conference_item.item_price(user1, nil)).to eql(200)
        expect(conference_item.item_price(user2, nil)).to eql(100)
      end
    end

    context 'discounted' do
      it 'should have a price of 50 with the discount key' do
        user = create(:user)
        conference_item = create(:conference_item)
        discount = create(:discount)

        price = create(:price,
          conference_item: conference_item,
          discount_key: discount.discount_key,
          amount: 50
        )

        expect(conference_item.item_price(user, discount.discount_key)).to eql(50)
      end
    end
  end

  describe '#number_of_paid_registrants' do
    it 'should count paid registrants and ignore unpaid' do
      conference_item = create(:conference_item_with_registered_users, paid_registrations: 4, unpaid_registrations: 2)
      expect(conference_item.number_of_paid_registrants).to eql(4)
    end
  end

  describe '#regular_priced_items' do
    it 'should load the price for a conference item in an active conference' do
      user = create(:user)
      conference = create(:conference)
      conference_item = create(:conference_item, conference: conference)
      set_price(conference_item, user, 100)

      conference_items = ConferenceItem.regular_priced_items(user)
      expect(conference_items.first.price).to eql(100)
    end

    it 'should not load conference items from inactive conferences' do
      user = create(:user)
      create(:conference) # there has to be an active conference to create an inactive conference
      conference = create(:conference, :inactive)
      conference_item = create(:conference_item, conference: conference)
      set_price(conference_item, user, 100)

      conference_items = ConferenceItem.regular_priced_items(user)
      expect(conference_items).to be_blank
    end
  end

  describe '#discounted_items' do
    it 'should load the discounted price for an item' do
      conference = create(:conference)
      conference_item = create(:conference_item, conference: conference)
      discount = create(:discount)
      create(:price,
        conference_item: conference_item,
        discount_key: discount.discount_key,
        amount: 50
      )

      conference_items = ConferenceItem.discounted_items(discount.discount_key)
      expect(conference_items.first.price).to eql(50)
    end
  end

  def set_price(conference_item, user, price)
    conference_item.prices.find_by(
      country_category: user.country_category,
      member: user.member
    ).update(amount: price)
  end
end
