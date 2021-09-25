class SurveyQuestionOption < ApplicationRecord
  belongs_to :question, class_name: "SurveyQuestion", foreign_key: :survey_question_id

  validates :label, presence: true
end
