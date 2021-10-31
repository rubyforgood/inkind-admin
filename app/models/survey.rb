class Survey < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :questions, class_name: "SurveyQuestion", dependent: :destroy
  has_many :responses, class_name: "SurveyResponse", dependent: :destroy

  validates :name, presence: true

  enum status: {inactive: 0, active: 1}

  def creator_name
    User.find(creator_id).name
  end
end
