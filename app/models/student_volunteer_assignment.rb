class StudentVolunteerAssignment < ApplicationRecord
  attribute :start_date, default: -> { Date.current }

  belongs_to :student
  belongs_to :volunteer, class_name: "User",
                         foreign_key: :volunteer_id,
                         inverse_of: :student_volunteer_assignments
  validates :start_date, presence: true
end
