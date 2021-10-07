# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    name { Faker::Name.name }
  end
end
