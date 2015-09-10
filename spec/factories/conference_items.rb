FactoryGirl.define do
  factory :conference_item do
    visibility true
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }

    trait :invisible do
      visibility false
    end

    factory :conference_item_with_registered_users do
      transient do
        paid_registrations 0
        unpaid_registrations 1
      end

      after(:create) do |conference_item, evaluator|
        itinerary = create(:itinerary, conference: conference_item.conference)
        create_list(:line_item, evaluator.paid_registrations, :paid, conference_item: conference_item, itinerary: itinerary)
        create_list(:line_item, evaluator.unpaid_registrations, conference_item: conference_item, itinerary: itinerary)
      end
    end
  end
end
