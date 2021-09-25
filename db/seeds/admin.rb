admin =
  User.create!(
    name: Faker::Name.name,
    email: 'admin@cep.dev',
    role: :admin,
    password: 'password',
    password_confirmation: 'password',
  )

puts "created admin: #{admin.email}:password"
