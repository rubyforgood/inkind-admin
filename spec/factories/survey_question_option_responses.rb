FactoryBot.define do
  factory :survey_question_option_response do
    association :option, factory: :survey_question_option
    association :question_response, factory: :survey_question_response
  end
end
