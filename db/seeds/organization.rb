Organization.destroy_all

cep = Organization.create!(name: "Community Education Partnerships")

puts "Created main organization: #{cep.name}"
