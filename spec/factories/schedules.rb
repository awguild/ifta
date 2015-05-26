FactoryGirl.define do
  factory :schedule do
    conference { FactoryGirl.create(:conference)}
  end
end