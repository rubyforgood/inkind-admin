class Student < ApplicationRecord
  include ExportToCsv

  has_many :student_volunteer_assignments
  has_many :volunteers, through: :student_volunteer_assignments
  belongs_to :deactivator, class_name: "User", optional: true

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}

  def active_student_volunteer_assignment
    @active_student_volunteer_assignment ||=
      StudentVolunteerAssignment.where(student: self).find_by("end_date > ?", Date.current)
  end

  def update_with_assignments!(student_attributes, volunteer_id)
    transaction do
      self.update(student_attributes)
      if active_student_volunteer_assignment.present? &&
         active_student_volunteer_assignment&.volunteer_id != volunteer_id.to_s
        active_student_volunteer_assignment.update(end_date: Date.current)
        StudentVolunteerAssignment.create(student: self, volunteer_id: volunteer_id, start_date: Date.current)
      elsif active_student_volunteer_assignment.blank?
        StudentVolunteerAssignment.create(student: self, volunteer_id: volunteer_id, start_date: Date.current)
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    first_name[0] + last_name[0]
  end

  def deactivate!(deactivator_id:)
    self.deactivated_at = Time.now
    self.deactivator_id = deactivator_id
    self.status = :inactive
    save!
  end

  def activate!
    self.status = :active
    save!
  end
end
