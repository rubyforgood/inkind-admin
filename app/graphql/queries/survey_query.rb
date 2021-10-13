module Queries
  module SurveyQuery
    extend ActiveSupport::Concern

    included do
      field :survey, Types::SurveyType, null: false do
        description "A single survey"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def survey(id:)
      Survey.find(id)
    end
  end
end
