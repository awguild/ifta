# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    tax_rate 0.02
    active false
    sequence(:conference_year) {|n| "200#{n}"}

    factory :active_conference do
      conference_year 2013
      active true
    end

    factory :inactive_conference do
      conference_year 2014
    end

    factory :conference_with_3_items do
      after(:create) do |conference, evaluator|
        3.times do
          item = conference.conference_items.build
          item.save
        end
      end
    end
  end
end
