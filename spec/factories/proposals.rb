FactoryBot.define do
  factory :proposal do
    format { 'poster' }
    category { 'Bullying' }
    title { 'How to avoid raising a bully' }
    short_description { 'Tips for encouraging positive behavior' }
    long_description { 'These ideas will help your kid play nice' }
    learning_objective { 'conflict resolution' }
    student { false }
    agree { true }
    no_equipment { true }
    keywords { 'Bullying' }
    language_english { true }
    user
    itinerary { create(:itinerary, user: user) }
    conference

    trait :student do
      student { true }
    end

    trait :accepted do
      status { 'accept' }
    end

    trait :rejected do
      status { 'decline' }
    end

    trait :wait_listed do
      status { 'wait list' }
    end

    trait :poster do
      format { 'poster' }
    end

    trait :fortyfivemin do
      format { '45min' }
    end

    factory :slotted_proposal, traits: [:accepted] do
      after(:create) do |proposal|
        create(:slot, proposal: proposal)
      end
    end
  end
end
