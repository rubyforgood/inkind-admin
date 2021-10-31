class StudentStaffAssignment < ApplicationRecord
  belongs_to :student
  belongs_to :staff, class_name: "User",
                     foreign_key: :staff_id

  validates :start_date, presence: true
end
