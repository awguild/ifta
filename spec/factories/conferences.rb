# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    tax_rate 0.02
    active true
    sequence(:conference_year) {|n| "200#{n}"}

    factory :active_conference do
      conference_year 2013
    end

    factory :inactive_conference do
      conference_year 2014
            active true
    end

    factory :conference_with_3_items do
      after(:create) do |conference, evaluator|
        3.times do
          item = conference.conference_items.build
          item.save
        end
      end
    end

    factory :conference_with_3_proposals do
      after(:create) do |conference, evaluator|
        3.times do
          FactoryGirl.create(:proposal, conference: conference)
        end
      end
    end
  end
end
