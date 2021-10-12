class User < ApplicationRecord
  include AuthenticationToken

  attr_accessor :skip_password_validation

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :students_users
  has_many :students, through: :students_users
  has_many :survey_responses

  validates :first_name, :last_name, presence: true

  enum status: {active: 0, inactive: 1}
  enum role: {volunteer: 0, admin: 1}

  def name
    "#{first_name} #{last_name}"
  end

  def password_required?
    return false if skip_password_validation
    super
  end
end
