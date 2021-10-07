# frozen_string_literal: true

User.volunteer.destroy_all

user =
  User.create!(
    first_name: 'Victor',
    last_name: 'Volunteer',
    email: 'volunteer@cep.dev',
    phone_number: Faker::PhoneNumber.cell_phone,
    password: 'password',
    password_confirmation: 'password'
  )
puts "Created volunteer: #{user.email}:password"

3.times do |n|
  user =
    User.create!(
      first_name: Faker::Name.gender_neutral_first_name,
      last_name: Faker::Name.last_name,
      email: "volunteer-#{n}@cep.dev",
      phone_number: Faker::PhoneNumber.cell_phone,
      password: 'password',
      password_confirmation: 'password'
    )
  puts "Created volunteer: #{user.email}:password"
end
