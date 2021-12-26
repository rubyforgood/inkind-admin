Student.destroy_all
StudentVolunteerAssignment.destroy_all
StudentStaffAssignment.destroy_all

User
  .where(role: :volunteer)
  .each do |volunteer|
    3.times do
      student =
        Student.create(
          first_name: Faker::Name.gender_neutral_first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          date_of_birth: Faker::Date.between(from: 18.years.ago, to: 5.years.ago),
          phone_number: Faker::PhoneNumber.phone_number,
          guardian_first_name: Faker::Name.gender_neutral_first_name,
          guardian_last_name: Faker::Name.last_name,
          guardian_phone_number: Faker::PhoneNumber.phone_number,
          guardian_email: Faker::Internet.email,
          emergency_contact_first_name: Faker::Name.gender_neutral_first_name,
          emergency_contact_last_name: Faker::Name.last_name,
          emergency_contact_phone_number: Faker::PhoneNumber.phone_number
        )

      StudentVolunteerAssignment.create!(
        student: student,
        volunteer: volunteer,
        start_date: Date.current,
        end_date: Date.new(3000)
      )

      StudentStaffAssignment.create!(
        student: student,
        staff: User.find_by(role: :admin),
        start_date: Date.current - 1.week,
        end_date: Date.new(3000)
      )

      puts "Created student: #{student.name}"
    end
  end
