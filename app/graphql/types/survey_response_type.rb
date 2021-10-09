module Types
  class SurveyResponseType < Types::Base::Object
    field :id, ID, null: false
    field :student, Types::StudentType, null: false
    field :volunteer, Types::UserType, null: false
    field :meeting_duration, Types::MeetingDurationType, null: true
  end
end
