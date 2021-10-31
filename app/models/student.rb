class Student < ApplicationRecord
  include ExportToCsv

  has_many :student_volunteer_assignments
  has_many :volunteers, through: :student_volunteer_assignments
  belongs_to :deactivator, class_name: "User", optional: true

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}

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
