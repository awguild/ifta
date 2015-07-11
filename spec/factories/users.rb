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
    country_id { Country.find_or_create_by({name: 'USA'}) }
    country_category 1
    phone "1112223333"
    username "jdoe@example.com"
    role "attendee"
    emergency_name "John Doe"
    emergency_relationship "Husband"
    emergency_telephone "1112223334"
    emergency_email "jdoe@example.com"
    password "abcdefgh"

    factory :admin do
        role "admin"
    end

    before(:create) do |user, evaluator|
        FactoryGirl.create(:usa)
    end
  end
end
