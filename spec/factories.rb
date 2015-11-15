FactoryGirl.define do
  factory :user do
    first_name "John"
    sequence(:email) { |n| "john-#{n}@example.com" }

    trait :with_full_details do
      url "example.com"
      github_name "johny"
      twitter_name "johnny"
      bio "Lorem ipsum dolor"
    end
  end
end
