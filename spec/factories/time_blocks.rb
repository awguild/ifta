# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :time_block do
    start_time 1.hour.from_now
    end_time 2.hours.from_now
  end
end
