FactoryBot.define do
  factory :conference do
    tax_rate { 0.02 }
    active { true }
    sequence(:conference_year) { |n| 2000 + n }

    trait :inactive do
      active { false }
    end
  end
end
