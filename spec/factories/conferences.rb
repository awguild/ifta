# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference do
    tax_rate 0.02
    active false

    factory :active_conference do
      conference_year 2013
      active true
    end

    factory :inactive_conference do
      conference_year 2014
    end

  end
end
