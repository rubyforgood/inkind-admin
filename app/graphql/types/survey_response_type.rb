# frozen_string_literal: true

module Types
  class SurveyResponseType < Types::BaseObject
    field :id, ID, null: false
    field :student, Types::StudentType, null: false
    field :volunteer, Types::UserType, null: false
    field :meeting_duration, Types::MeetingDurationType, null: true
  end
end
