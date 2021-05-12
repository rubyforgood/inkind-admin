FactoryBot.define do
  factory :user do
    name { 'Jan Doen' }
    sequence(:email) { |n| "admin-#{n}@example.edu" }
    password { 'password' }
    role { 'admin' }
  end
end
