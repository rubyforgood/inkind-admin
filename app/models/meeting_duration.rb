class MeetingDuration < ApplicationRecord
  belongs_to :survey_response

  validates :minutes, presence: true
end
