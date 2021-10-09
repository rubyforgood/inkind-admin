module Types
  module Base
    class Object < GraphQL::Schema::Object
      edge_type_class(Types::Base::Edge)
      connection_type_class(Types::Base::Connection)
      field_class Types::Base::Field
    end
  end
end
