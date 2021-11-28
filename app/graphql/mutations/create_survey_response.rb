module Mutations
  class CreateSurveyResponse < Base::Mutation
    null true

    argument :survey_id, ID, required: true
    argument :user_id, ID, required: true
    argument :student_id, ID, required: true

    field :response, Types::SurveyResponseType, null: false

    def resolve(survey_id:, user_id:, student_id:)
      response = SurveyResponse.create!(survey_id: survey_id, user_id: user_id, student_id: student_id)
      { response: response }
    end
  end
end
