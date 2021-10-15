class Student < ApplicationRecord
  include ExportToCsv

  has_many :students_users
  has_many :users, through: :students_users
  belongs_to :deactivator, class_name: "User",
                           optional: true

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
