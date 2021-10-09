module Mutations
  module Base
    class Mutation < GraphQL::Schema::Mutation
      null false
    end
    # class Mutation < GraphQL::Schema::RelayClassicMutation
    #   argument_class Types::Base::Argument
    #   field_class Types::Base::Field
    #   input_object_class Types::Base::InputObject
    #   object_class Types::Base::Object
    # end
  end
end
