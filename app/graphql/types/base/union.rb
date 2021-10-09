module Types
  module Base
    class Union < GraphQL::Schema::Union
      edge_type_class(Edge)
      connection_type_class(Connection)
    end
  end
end
