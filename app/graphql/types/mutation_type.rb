module Types
  class MutationType < Base::Object
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_survey_response, mutation: Mutations::CreateSurveyResponse
    field :create_survey_question_response, mutation: Mutations::CreateSurveyQuestionResponse
  end
end
