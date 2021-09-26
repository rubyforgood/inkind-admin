FactoryBot.define do
  factory :survey_question do
    survey
    prompt { Faker::Lorem.question }

    trait :single_select do
      options
    end

    trait :multi_select do
      options
    end
  end
end
