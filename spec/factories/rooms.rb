FactoryGirl.define do
  factory :room do
    schedule {FactoryGirl.create(:schedule)}
    label 'Blue Room'
  end
end