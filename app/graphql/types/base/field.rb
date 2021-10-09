module Types
  module Base
    class Field < GraphQL::Schema::Field
      argument_class Argument
    end
  end
end
