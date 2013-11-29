# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # this factory allows us to call FactoryGirl.build(:ifta_member) or FactoryGirl.create(:ifta_member) in our specs
  # it will create an instance of the IftaMember class with the properties defined below
  factory :ifta_member do
    email 'jdoe@example.com'

    # you can nest factories inside of each other so that the member_with_user factory inherits all the properties set by ifta_member (but it can override properties or set its own)
    factory :member_with_user do
      # you can use the after create callback to create associations between records
      # whenever a member_with_user factory is created factory girl will create a user record and associate it with this record
      after(:create) do |ifta_member, evaluator|
            FactoryGirl.create(:user, :ifta_member => ifta_member)
      end
    end
  end
end
