module Types
  class MeetingDurationType < Types::Base::Object
    field :id, ID, null: false
    field :started_at, String, null: false
    field :minutes, Int, null: false
  end
end
