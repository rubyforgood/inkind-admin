class SurveyQuestionResponse < ApplicationRecord
  belongs_to :response, class_name: "SurveyResponse", foreign_key: :survey_response_id
  belongs_to :question, class_name: "SurveyQuestion", foreign_key: :survey_question_id
end
