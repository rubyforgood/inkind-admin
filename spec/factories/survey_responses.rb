FactoryBot.define do
  factory :survey_response do
    survey
    student
    user { create(:user, :volunteer) }
  end
end
