FactoryGirl.define do
  factory :itinerary do
    conference { FactoryGirl.create(:conference)}
    user { FactoryGirl.create(:user)}
  end
end