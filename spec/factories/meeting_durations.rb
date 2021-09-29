FactoryBot.define do
  factory :meeting_duration do
    survey_response
    minutes { 45 }
    started_at { Time.zone.now - 1.day }
  end
end
