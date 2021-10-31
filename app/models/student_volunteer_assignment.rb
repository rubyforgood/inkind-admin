class StudentVolunteerAssignment < ApplicationRecord
  belongs_to :student
  belongs_to :volunteer, class_name: "User",
                         foreign_key: :volunteer_id

  validates :start_date, presence: true
end
