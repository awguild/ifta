FactoryGirl.define do
  factory :itinerary do
    conference { FactoryGirl.create(:conference)}
    user { FactoryGirl.create(:user)}

    factory :itinerary_with_pending_conference do
      after(:create) do |itinerary, evaluator|
        line_item = FactoryGirl.create(:pending_conference_line_item)
        line_item.itinerary = itinerary
        line_item.save
      end
    end

    factory :itinerary_with_paid_conference do
      after(:create) do |itinerary, evaluator|
        line_item = FactoryGirl.build(:paid_conference_line_item)
        line_item.itinerary = itinerary
        line_item.save
      end
    end
  end
end