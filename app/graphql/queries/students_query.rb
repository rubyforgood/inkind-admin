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
      context[:current_user]&.students.find_by(id: id)
    end

    def students
      context[:current_user]&.students
    end
  end
end
