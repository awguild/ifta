FactoryBot.define do
  factory :conference_item do
    visibility { true }
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }

    trait :invisible do
      visibility { false }
    end
  end
end
