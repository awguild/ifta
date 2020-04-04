FactoryBot.define do
  factory :ifta_member do
    email 'jdoe@example.com'

    factory :member_with_user do
      after(:create) do |ifta_member, evaluator|
        create(:user, ifta_member: ifta_member)
      end
    end
  end
end
