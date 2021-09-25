User.admin.destroy_all

admin =
  User.create!(
    name: 'Addy Admin',
    email: 'admin@cep.dev',
    role: :admin,
    password: 'password',
    password_confirmation: 'password',
  )

puts "Created admin: #{admin.email}:password"
