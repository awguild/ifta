FactoryBot.define do
  factory :conference do
    tax_rate { 0.02 }
    active { true }
    sequence(:conference_year) { |n| 2000 + n }

    trait :inactive do
      active { false }
    end

    factory :conference_with_items do
      transient do
        active_items { 3 }
        inactive_items { 0 }
      end

      after(:create) do |conference, evaluator|
        create_list(:conference_item, evaluator.active_items, conference: conference)
        create_list(:conference_item, evaluator.inactive_items, :invisible, conference: conference)
      end
    end

    factory :conference_with_proposals do
      transient do
        num_proposals { 3 }
      end

      after(:create) do |conference, evaluator|
        user = create(:user)
        itinerary = create(:itinerary, conference: conference, user: user)
        create_list(:proposal, evaluator.num_proposals, conference: conference, user: user, itinerary: itinerary)
      end
    end

    factory :conference_with_slots, :aliases => [:conference_with_rooms] do
      transient do
        num_time_blocks { 1 }
        num_rooms { 3 }
      end

      after(:create) do |conference, evaluator|
        create_list(:room, evaluator.num_rooms, schedule: conference.schedule)
        create_list(:time_block, evaluator.num_time_blocks, schedule: conference.schedule)
      end
    end
  end
end
