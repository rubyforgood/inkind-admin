class Survey < ApplicationRecord
  has_many :questions, class_name: "SurveyQuestion", dependent: :destroy
  has_many :responses, class_name: "SurveyResponse", dependent: :destroy

  validates :name, presence: true
end
