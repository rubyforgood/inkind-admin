class Student < ApplicationRecord
  include ExportToCsv

  has_many :student_volunteer_assignments
  has_many :volunteers, through: :student_volunteer_assignments

  has_many :student_staff_assignments

  belongs_to :deactivator, class_name: "User", optional: true

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}

  def active_student_volunteer_assignment
    @active_student_volunteer_assignment ||=
      StudentVolunteerAssignment.where(student: self).find_by("end_date > ?", Date.current)
  end

  def active_student_staff_assignment
    @active_student_staff_assignment ||=
      StudentStaffAssignment.where(student: self).find_by("end_date > ?", Date.current)
  end

  def update_with_assignments!(student_attributes:, volunteer_id:, staff_id:)
    transaction do
      update_volunteer_assignment(volunteer_id.to_s)
      update_staff_assignment(staff_id.to_s)
      update(student_attributes)
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

  private

  def update_volunteer_assignment(volunteer_id)
    if active_student_volunteer_assignment.present? &&
        active_student_volunteer_assignment.volunteer_id.to_s != volunteer_id
      active_student_volunteer_assignment.update!(end_date: Date.current)
      StudentVolunteerAssignment.create!(student: self, volunteer_id: volunteer_id, start_date: Date.current) if volunteer_id.present?
    elsif active_student_volunteer_assignment.blank?
      StudentVolunteerAssignment.create!(student: self, volunteer_id: volunteer_id, start_date: Date.current) if volunteer_id.present?
    end
  end

  def update_staff_assignment(staff_id)
    if active_student_staff_assignment.present? &&
        active_student_staff_assignment.staff_id.to_s != staff_id
      active_student_staff_assignment.update!(end_date: Date.current)
      StudentStaffAssignment.create!(student: self, staff_id: staff_id, start_date: Date.current) if staff_id.present?
    elsif active_student_staff_assignment.blank?
      StudentStaffAssignment.create!(student: self, staff_id: staff_id, start_date: Date.current) if staff_id.present?
    end
  end
end
