module Types
  module Base
    class Edge < Types::Base::Object
      # add `node` and `cursor` fields, as well as `node_type(...)` override
      include GraphQL::Types::Relay::EdgeBehaviors
    end
  end
end
