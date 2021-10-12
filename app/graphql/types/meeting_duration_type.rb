module Types
  class MeetingDurationType < Base::Object
    field :id, ID, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :minutes, Int, null: false
  end
end
