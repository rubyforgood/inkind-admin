class Student < ApplicationRecord
  has_many :students_users
  has_many :users, through: :students_users
end
