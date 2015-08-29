FactoryGirl.define do
  factory :proposal do
    format 'poster'
    category 'Bullying'
    title 'How to avoid raising a bully'
    short_description 'Tips for encouraging positive behavior'
    long_description 'These ideas will help your kid play nice'
    student false
    agree true
    itinerary { FactoryGirl.create(:itinerary) }
    no_equipment true
    keywords 'Bullying'
    language_english true
    conference { FactoryGirl.create(:conference) } #not quite right, should have same conference as itinerary

    factory :student_proposal do
      student true
    end

    factory :accepted_proposal_with_presenter do
      status 'accept'
      after(:create) do |proposal|
        proposal.presenters << FactoryGirl.create(:presenter)
      end
    end

    factory :rejected_proposal_with_presenter do
      status 'decline'
      after(:create) do |proposal|
        proposal.presenters << FactoryGirl.create(:presenter)
      end
    end

    factory :wait_listed_proposal_with_presenter do
      status 'wait list'
      after(:create) do |proposal|
        proposal.presenters << FactoryGirl.create(:presenter)
      end
    end

    factory :slotted_proposal_with_presenter do
      status 'accept'
      after(:create) do |proposal|
        proposal.presenters << FactoryGirl.create(:presenter)
        proposal.create_slot!
      end
    end

    trait :poster do
      format 'poster'
    end

    trait :fortyfivemin do
      format '45min'
    end
  end
end
