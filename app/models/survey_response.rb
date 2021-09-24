class SurveyResponse < ApplicationRecord
  belongs_to :volunteer, class_name: "User"
  belongs_to :student
  belongs_to :survey

  validates :volunteer, :student, :survey, presence: true
end
