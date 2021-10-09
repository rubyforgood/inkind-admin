module Types
  module Base
    class InputObject < GraphQL::Schema::InputObject
      argument_class Argument
    end
  end
end
