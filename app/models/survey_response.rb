class SurveyResponse < ApplicationRecord
  belongs_to :volunteer, class_name: "User", foreign_key: :user_id
  belongs_to :student
  belongs_to :survey

  validates :volunteer, :student, :survey, presence: true
end
