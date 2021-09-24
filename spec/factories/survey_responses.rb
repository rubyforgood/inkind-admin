FactoryBot.define do
  factory :survey_response do
    survey
    student
    association :volunteer, factory: :user
  end
end
