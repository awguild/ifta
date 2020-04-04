FactoryBot.define do
  factory :itinerary do
    conference
    user

    factory :itinerary_with_item do
      transient do
        item_name 'Conference'
        paid false
      end

      after(:create) do |itinerary, evaluator|
        conference_item = create(:conference_item, conference: itinerary.conference, name: evaluator.item_name)
        create(:line_item, paid: evaluator.paid, itinerary: itinerary, conference_item: conference_item)
      end
    end
  end
end
