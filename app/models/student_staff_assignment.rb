class StudentStaffAssignment < ApplicationRecord
  belongs_to :student
  belongs_to :staff, class_name: "User",
                     foreign_key: :staff_id,
                     inverse_of: :student_staff_assignments

  validates :start_date, presence: true
end
