module Types
  class SurveyResponseType < Base::Object
    field :id, ID, null: false
    field :student, StudentType, null: false
    field :volunteer, UserType, null: false
    field :meeting_duration, MeetingDurationType, null: true
  end
end
