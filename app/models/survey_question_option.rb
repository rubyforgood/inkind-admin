class SurveyQuestionOption < ApplicationRecord
  belongs_to :question, foreign_key: :survey_question_id

  validates :label, presence: true
end
