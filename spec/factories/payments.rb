FactoryGirl.define do
  factory :payment do
    amount 100
    confirmed false

    trait :confirmed do
      confirmed true
    end

    trait :unconfirmed do
      confirmed false
    end
  end
end
