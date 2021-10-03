class Student < ApplicationRecord
  has_many :students_users
  has_many :users, through: :students_users

  enum status: {active: 0, inactive: 1}
end
