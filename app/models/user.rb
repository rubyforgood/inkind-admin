class User < ApplicationRecord
  include AuthenticationToken

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  enum role: { volunteer: 0, admin: 1 }

  has_many :students_users
  has_many :students, through: :students_users
end
