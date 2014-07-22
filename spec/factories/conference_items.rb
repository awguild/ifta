# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conference_item do
    visibility true
    conference { FactoryGirl.create(:conference)}
    name 'conference'
    description '2014 conference'

    factory :not_visible_conference_item do
      visibility false
    end
  end
end
