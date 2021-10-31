FactoryBot.define do
  factory :student_staff_assignment do
    student
    staff
    start_date { Date.current }
  end
end
