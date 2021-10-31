FactoryBot.define do
  factory :student_volunteer_assignment do
    student
    volunteer
    start_date { Date.current }
  end
end
