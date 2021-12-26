FactoryBot.define do
  factory :student do
    first_name { Faker::Name.gender_neutral_first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    date_of_birth { 13.years.ago + (rand(600) * (rand > 0.5 ? -1 : 1)) }
    guardian_email { Faker::Internet.email }

    trait :archived do
      sequence(:archived_at) { |n| n.days.ago }
    end
  end
end
