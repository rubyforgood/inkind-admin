class Survey < ApplicationRecord
  has_many :questions, class_name: "SurveyQuestion", dependent: :destroy
  has_many :responses, class_name: "SurveyResponse", dependent: :destroy

  validates :name, presence: true

  scope :complete, -> { where(status: "complete") }

  enum status: {Inactive: 0, Active: 1}

  def creator_name
    User.find(creator_id).name
  end
end
