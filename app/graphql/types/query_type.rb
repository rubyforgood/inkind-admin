# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include Queries::CurrentUserQuery
    include Queries::StudentsQuery
    include Queries::SurveyResponsesQuery
  end
end
