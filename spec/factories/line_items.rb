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
  end
end