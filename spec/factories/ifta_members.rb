FactoryBot.define do
  factory :ifta_member do
    sequence(:email) { |n| "jdoe#{n}@example.com" }
  end
end
