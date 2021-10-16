class MeetingDuration < ApplicationRecord
  belongs_to :survey_response

  validates :minutes, :started_at, :survey_response, presence: true

  after_create :complete_response

  private

  def complete_response
    survey_response.complete!
  end
end
