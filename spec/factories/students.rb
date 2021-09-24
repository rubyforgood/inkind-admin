FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    date_of_birth { 13.years.ago + (rand(600) * (rand > 0.5 ? -1 : 1)) }

    trait :archived do
      sequence(:archived_at) { |n| n.days.ago }
    end
  end
end
