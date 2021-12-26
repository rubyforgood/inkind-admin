class Student < ApplicationRecord
  include ExportToCsv

  EXPORT_HEADERS = ["First Name", "Last Name", "Volunteer Name(s)", "Staff Contact", "DOB", "Guardian First Name",
    "Guardian Last Name", "Guardian Email", "Guardian Phone", "Emergency Contact First Name",
    "Emergency Contact Last Name", "Emergency Contact Phone", "Hours logged", "Number of sessions",
    "City", "State"].freeze

  EXPORT_COLUMNS = %w[first_name last_name volunteer_names_for_csv staff.name
                      date_of_birth guardian_first_name guardian_last_name
                      guardian_email guardian_phone_number emergency_contact_first_name emergency_contact_last_name
                      emergency_contact_phone_number hours_logged completed_responses.count city state].freeze

  has_many :student_volunteer_assignments
  has_many :active_student_volunteer_assignments, lambda {
                                                    where("student_volunteer_assignments.end_date > ?", Date.current)
                                                  }, class_name: "StudentVolunteerAssignment"
  has_many :volunteers, through: :active_student_volunteer_assignments

  has_many :survey_responses
  has_many :completed_responses, -> { where(status: "complete") }, class_name: "SurveyResponse"
  has_many :meeting_durations, through: :completed_responses

  has_many :student_staff_assignments
  has_one :active_student_staff_assignment, lambda {
                                              where("student_staff_assignments.end_date > ?", Date.current)
                                            }, class_name: "StudentStaffAssignment"
  has_one :staff, through: :active_student_staff_assignment

  belongs_to :deactivator, class_name: "User", optional: true

  validates :first_name, :last_name, presence: true
  validates :state, length: {minimum: 2, maximum: 2}, allow_blank: true

  enum status: {active: 0, inactive: 1}

  def update_with_assignments!(student_attributes:, staff_id:, volunteer_ids: [])
    transaction do
      update_staff_assignment(staff_id.to_s)
      update_volunteer_assignments(volunteer_ids: volunteer_ids)
      update(student_attributes)
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def guardian_name
    "#{guardian_last_name}, #{guardian_first_name}"
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

  def hours_logged
    total_minutes = meeting_durations.sum(:minutes)
    hours = total_minutes / 60
    minutes = total_minutes % 60
    "#{hours}:#{minutes}"
  end

  def volunteer_names_for_csv
    volunteers.map(&:name).join("/")
  end

  private

  def update_volunteer_assignments(volunteer_ids: [])
    active_volunteer_ids = active_student_volunteer_assignments.pluck(:volunteer_id).map(&:to_s).sort || []
    volunteer_ids ||= []

    return if active_volunteer_ids == volunteer_ids&.sort

    volunteer_ids.compact_blank!

    inactive_ids = active_volunteer_ids - volunteer_ids
    if inactive_ids.present?
      active_student_volunteer_assignments.where(volunteer_id: inactive_ids).update(end_date: Date.current)
    end

    new_volunteers = volunteer_ids - active_volunteer_ids
    new_volunteers.each do |volunteer_id|
      StudentVolunteerAssignment.create!(student: self, volunteer_id: volunteer_id, start_date: Date.current)
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
