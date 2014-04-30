# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day do
    schedule_id '1'
    label 'Monday'
    day_date Time.now
  end
end
