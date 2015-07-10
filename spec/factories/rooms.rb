FactoryGirl.define do
  factory :room do
    schedule {FactoryGirl.create(:conference).schedule}
    label 'Blue Room'
  end
end