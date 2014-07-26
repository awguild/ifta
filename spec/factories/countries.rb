# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    factory :usa do
        name "USA"
        category 1
    end
  end
end
