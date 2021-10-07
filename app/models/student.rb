class Student < ApplicationRecord
  has_many :students_users
  has_many :users, through: :students_users

  validates :first_name, :last_name, presence: true

  enum status: { active: 0, inactive: 1 }

  def name
    "#{first_name} #{last_name}"
  end
end
