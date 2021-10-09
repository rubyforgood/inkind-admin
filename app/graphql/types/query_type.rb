module Types
  class QueryType < Base::Object
    include Queries::CurrentUserQuery
    include Queries::StudentsQuery
    include Queries::SurveyResponsesQuery
  end
end
