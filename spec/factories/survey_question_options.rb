# frozen_string_literal: true

FactoryBot.define do
  factory :survey_question_option do
    association :question, factory: :survey_question
    label { Faker::Lorem.sentence }
  end
end
