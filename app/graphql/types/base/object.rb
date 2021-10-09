module Types
  module Base
    class Object < GraphQL::Schema::Object
      edge_type_class(Edge)
      connection_type_class(Connection)
      field_class(Field)
    end
  end
end
