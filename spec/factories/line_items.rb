FactoryGirl.define do
  factory :line_item do
    price 0
    conference_item { FactoryGirl.create(:conference_item)}
    itinerary { FactoryGirl.create(:itinerary)}

    factory :unpaid_line_item do
    end

    factory :paid_line_item do
      paid true
    end

    factory :pending_conference_line_item do
      paid false
      conference_item { FactoryGirl.create(:conference_2014_conference_item)}
    end

    factory :paid_conference_line_item do
      paid true
      conference_item { FactoryGirl.create(:conference_2014_conference_item)}
    end
  end
end