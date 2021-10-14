class User < ApplicationRecord
  include AuthenticationToken

  attr_accessor :skip_password_validation

  devise :database_authenticatable, :registerable, :validatable,
    :password_expirable, :recoverable, :rememberable

  has_many :students_users
  has_many :students, through: :students_users
  has_many :survey_responses

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
end
