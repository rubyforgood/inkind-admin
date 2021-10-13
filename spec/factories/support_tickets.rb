FactoryBot.define do
  factory :support_ticket do
    description { Faker::Lorem.sentence }
    association :requestor, factory: :user
  end
end
