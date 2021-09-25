user =
  User.create!(
    name: Faker::Name.name,
    email: 'volunteer@cep.dev',
    password: 'password',
    password_confirmation: 'password',
  )
puts "created volunteer: #{user.email}:password"

3.times do |n|
  user =
    User.create!(
      name: Faker::Name.name,
      email: "volunteer-#{n}@cep.dev",
      password: 'password',
      password_confirmation: 'password',
    )
  puts "created volunteer: #{user.email}:password"
end
