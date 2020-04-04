FactoryBot.define do
  factory :line_item do
    price { 0 }
    paid { false }

    trait :paid do
      paid { true }
    end

    trait :unpaid do
      paid { false }
    end
  end
end
