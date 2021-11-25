module Types
  class MutationType < Base::Object
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_support_ticket, mutation: Mutations::CreateSupportTicket
    field :create_survey_response, mutation: Mutations::CreateSurveyResponse
    field :update_user, mutation: Mutations::UpdateUser
    field :update_user_password, mutation: Mutations::UpdateUserPassword
    field :upsert_survey_question_response, mutation: Mutations::UpsertSurveyQuestionResponse
  end
end
