# frozen_string_literal: true

FactoryBot.define do
  factory :survey_response do
    survey
    student
    association :volunteer, factory: :user
  end
end
