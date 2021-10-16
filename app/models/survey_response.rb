class SurveyResponse < ApplicationRecord
  belongs_to :volunteer, class_name: "User", foreign_key: :user_id
  belongs_to :student
  belongs_to :survey
  has_one :meeting_duration

  has_many :question_responses, class_name: "SurveyQuestionResponse", dependent: :destroy

  validates :volunteer, :student, :survey, presence: true

  enum status: {incomplete: 0, complete: 1}
end
