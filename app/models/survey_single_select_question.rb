# frozen_string_literal: true

class SurveySingleSelectQuestion < SurveyQuestion
  has_many :options, class_name: 'SurveyQuestionOption',
                     foreign_key: :survey_question_id,
                     dependent: :destroy
end
