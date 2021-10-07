# frozen_string_literal: true

FactoryBot.define do
  factory :survey_question_response do
    association :question, factory: :survey_question
    association :response, factory: :survey_response
    reply { Faker::Lorem.sentence }
  end
end
