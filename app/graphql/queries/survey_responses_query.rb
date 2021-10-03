module Queries
  module SurveyResponsesQuery
    extend ActiveSupport::Concern

    included do
      field :survey_responses,
        [Types::SurveyResponseType],
        null: true,
        description: "All survey_responses associated with signed in volunteer"
    end

    def survey_responses
      context[:current_user]&.survey_responses
    end
  end
end
