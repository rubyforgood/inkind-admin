class SurveySupportTicketQuestion < SurveyQuestion
  has_many :options, class_name: "SurveyQuestionOption",
                     foreign_key: :survey_question_id,
                     dependent: :destroy

  # SurveySupportTicketQuestions are SingleSelectQuestions that have 2 options: Yes/No
  # In the survey-taking app, inkind-volunteer, if "Yes" is selected, then a
  # follow up Support Ticket form is prompted.
  # If "No" is selected, then no Support Ticket form is prompted.
end
