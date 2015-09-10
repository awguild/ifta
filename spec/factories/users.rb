# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "jdoe#{n}@example.com" }
    first_name 'Jane'
    last_name 'Doe'
    prefix 'Mrs'
    initial 'A'
    address '123 Main St'
    city 'Springfield'
    state 'IL'
    zip 12345
    country
    country_category { country.category }
    phone '1112223333'
    username 'jdoe@example.com'
    role 'attendee'
    emergency_name 'John Doe'
    emergency_relationship 'Husband'
    emergency_telephone '1112223334'
    emergency_email 'jdoe@example.com'
    password 'abcdefgh'

    trait :admin do
      role 'admin'
    end

    trait :category2 do
      country_category 2
    end

    trait :member do
      member true
      ifta_member
      ifta_member_email { ifta_member.email }
    end
  end
end
