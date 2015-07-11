FactoryGirl.define do
  factory :payment do
    order { FactoryGirl.create(:transaction)}
    amount 100
    confirmed true

    factory :unconfirmed_payment do
      confirmed false
    end

    factory :confirmed_payment do
      confirmed true
    end
  end
end