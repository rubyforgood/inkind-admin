module Types
  module Base
    module Interface
      include GraphQL::Schema::Interface

      edge_type_class(Edge)
      connection_type_class(Connection)
      field_class(Field)
    end
  end
end
