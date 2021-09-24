module Queries
  module StudentsQuery
    extend ActiveSupport::Concern

    included do
      field :student, Types::StudentType, null: false do
        description 'A single student'
        argument :id, GraphQL::Types::ID, required: true
      end

      field :students,
            [Types::StudentType],
            null: true,
            description: 'All students associated with signed in volunteer'
    end

    def student(id:)
      Student.find(id)
    end

    def students
      # FIXME: get authenticated_volunteer from context
      Student.all
    end
  end
end
