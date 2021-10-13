Student.destroy_all

User
  .where(role: :volunteer)
  .each do |user|
    3.times do
      student =
        Student.create(
          first_name: Faker::Name.gender_neutral_first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          date_of_birth: Faker::Date.between(from: 18.years.ago, to: 5.years.ago),
          phone_number: Faker::PhoneNumber.phone_number,
          guardian_name: Faker::Name.name,
          guardian_phone_number: Faker::PhoneNumber.phone_number,
          emergency_contact_name: Faker::Name.name,
          emergency_contact_phone_number: Faker::PhoneNumber.phone_number,
          users: [user]
        )
      puts "Created student: #{student.name}"
    end
  end
