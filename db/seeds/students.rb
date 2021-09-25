Student.destroy_all

User
  .where(role: :volunteer)
  .each do |user|
    3.times do
      student =
        Student.create(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          date_of_birth:
            Faker::Date.between(from: 18.years.ago, to: 5.years.ago),
          phone_number: Faker::PhoneNumber.phone_number,
          nickname: Faker::Name.gender_neutral_first_name,
          users: [user]
        )
      puts "Created student: #{student.name}"
    end
  end
