class Student < ApplicationRecord
  include ExportToCsv

  has_many :student_volunteer_assignments
  has_many :volunteers, through: :student_volunteer_assignments
  has_one :active_student_volunteer_assignment, -> { where("end_date > ?", Date.current) }, class_name: "StudentVolunteerAssignment"

  has_many :student_staff_assignments
  has_many :staff, through: :student_staff_assignments
  has_one :active_student_staff_assignment, -> { where("end_date > ?", Date.current) }, class_name: "StudentStaffAssignment"

  belongs_to :deactivator, class_name: "User", optional: true

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}

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

  def guardian_full_name
    "#{guardian_first_name} #{guardian_last_name}"
  end

  def emergency_contact_full_name
    "#{emergnecy_contact_first_name} #{emergency_conatct_last_name}"
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
