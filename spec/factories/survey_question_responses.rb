FactoryBot.define do
  factory :survey_question_response do
    survey_question
    survey_response
    reply { Faker::Lorem.sentence }
  end
end
