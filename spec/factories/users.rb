FactoryBot.define do
  factory :user do
    first_name { Faker::Name.gender_neutral_first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    factory :admin do
      sequence(:email) { |n| "admin-#{n}@example.edu" }
      role { User.roles[:admin] }
    end

    factory :volunteer do
      sequence(:email) { |n| "volunteer-#{n}@example.edu" }
      role { User.roles[:volunteer] }
    end
  end
end
