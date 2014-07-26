FactoryGirl.define do
  factory :discount do
    description 'Discount for Augie students'
    conference { FactoryGirl.create(:conference) }
  end
end