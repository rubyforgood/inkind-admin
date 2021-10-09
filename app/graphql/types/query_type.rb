module Types
  class QueryType < Types::Base::Object
    include Queries::CurrentUserQuery
    include Queries::StudentsQuery
    include Queries::SurveyResponsesQuery
  end
end
