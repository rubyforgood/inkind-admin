User.admin.destroy_all

admin =
  User.create!(
    first_name: "Addy",
    last_name: "Admin",
    email: "admin@cep.dev",
    role: :admin,
    password: "password",
    password_confirmation: "password"
  )

puts "Created admin: #{admin.email}:password"
