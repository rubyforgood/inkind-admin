module Types
  module Base
    class Edge < Object
      # add `node` and `cursor` fields, as well as `node_type(...)` override
      include GraphQL::Types::Relay::EdgeBehaviors
    end
  end
end
