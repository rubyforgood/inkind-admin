FactoryBot.define do
  factory :survey do
    name { Faker::Name.name }
    creator { create(:user, role: :admin) }
  end
end
