# frozen_string_literal: true

class SurveyQuestionOptionResponse < ApplicationRecord
  belongs_to :option, class_name: 'SurveyQuestionOption',
                      foreign_key: :survey_question_option_id
  belongs_to :question_response, class_name: 'SurveyQuestionResponse',
                                 foreign_key: :survey_question_response_id
end
