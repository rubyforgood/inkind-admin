class User < ApplicationRecord
  include AuthenticationToken
  include ExportToCsv

  VOLUNTEER_EXPORT_HEADERS = [
    "Name", "Status", "Email", "Phone Number", "Student Name(s)", "Staff Contact(s)", "Last Seen",
    "Number of Sessions", "Minutes Logged", "Outstanding Ticket Request", "Total Support Created"
  ]
  VOLUNTEER_EXPORT_COLUMNS = %w[
    name status email phone_number student_names staff_names last_seen completed_responses.count
    minutes_logged open_ticket_request? support_tickets.count
  ]

  attr_accessor :skip_password_validation

  devise :database_authenticatable, :registerable, :validatable,
    :password_expirable, :recoverable, :rememberable

  has_many :survey_responses
  has_many :completed_responses, -> { where(status: "complete") }, class_name: "SurveyResponse"
  has_many :meeting_durations, through: :completed_responses
  has_many :support_tickets, foreign_key: :requestor_id

  # relationships on an admin
  has_many :student_staff_assignments, -> { where("student_staff_assignments.end_date > ?", Date.current) }, inverse_of: :staff, foreign_key: :staff_id
  has_many :managed_students, through: :student_staff_assignments, source: :student
  has_many :volunteers, -> { distinct }, through: :managed_students

  # relationships on a volunteer
  has_many :student_volunteer_assignments, -> { where("student_volunteer_assignments.end_date > ?", Date.current) }, inverse_of: :volunteer, foreign_key: :volunteer_id
  has_many :students, through: :student_volunteer_assignments, source: :student
  has_many :staff, -> { distinct }, through: :students

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}
  enum role: {volunteer: 0, admin: 1}

  def active_for_authentication?
    super && active?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    first_name[0] + last_name[0]
  end

  def password_required?
    return false if skip_password_validation
    super
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

  def open_ticket_request?
    support_tickets.where(status: :active).size > 0
  end

  def student_names
    students.map(&:name).join(", ")
  end

  def staff_names
    staff.map(&:name).join(", ")
  end

  def last_seen
    survey_responses.maximum(:updated_at)&.strftime("%m/%d/%Y")
  end

  def minutes_logged
    meeting_durations.sum(:minutes)
  end
end
