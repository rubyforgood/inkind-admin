module Queries
  module SurveyResponsesQuery
    extend ActiveSupport::Concern

    included do
      field :survey_responses,
        [Types::SurveyResponseType],
        null: true,
        description: "All survey_responses associated with signed in volunteer"

      field :student_survey_responses, [Types::SurveyResponseType], null: true do
        description "All survey_responses for a specific student associated with signed in volunteer"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def survey_responses
      context[:current_user]&.survey_responses
    end

    def student_survey_responses(id:)
      context[:current_user]&.survey_responses&.where(student_id: id)
    end
  end
end
