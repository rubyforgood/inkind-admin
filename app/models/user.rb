# frozen_string_literal: true

class User < ApplicationRecord
  include AuthenticationToken

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :students_users
  has_many :students, through: :students_users
  has_many :survey_responses

  validates :first_name, :last_name, presence: true

  enum status: { active: 0, inactive: 1 }
  enum role: { volunteer: 0, admin: 1 }

  def name
    "#{first_name} #{last_name}"
  end
end
