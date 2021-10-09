module Types
  module Base
    class Union < GraphQL::Schema::Union
      edge_type_class(Types::Base::Edge)
      connection_type_class(Types::Base::Connection)
    end
  end
end
