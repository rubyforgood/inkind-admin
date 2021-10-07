# frozen_string_literal: true

module Types
  class MeetingDurationType < Types::BaseObject
    field :id, ID, null: false
    field :started_at, String, null: false
    field :minutes, Int, null: false
  end
end
