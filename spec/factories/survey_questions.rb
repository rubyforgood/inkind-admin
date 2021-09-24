FactoryBot.define do
  factory :survey_question do
    survey
    prompt { Faker::Lorem.question }
  end
end
