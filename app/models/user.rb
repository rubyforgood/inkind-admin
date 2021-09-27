class User < ApplicationRecord
  include AuthenticationToken

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :students_users
  has_many :students, through: :students_users

  enum status: { active: 0, inactive: 1 }
  enum role: { volunteer: 0, admin: 1 }
end
