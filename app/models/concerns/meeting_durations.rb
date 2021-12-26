module MeetingDurations
  extend ActiveSupport::Concern

  included do
    has_many :survey_responses
    has_many :completed_responses, -> { where(status: "complete") }, class_name: "SurveyResponse"
    has_many :meeting_durations, through: :completed_responses
    has_many :support_tickets, foreign_key: :requestor_id
  end

  def minutes_logged
    meeting_durations.sum(:minutes)
  end

  def hours_logged
    total_minutes = meeting_durations.sum(:minutes)
    hours = total_minutes / 60
    minutes = total_minutes % 60
    "#{hours}:#{minutes}"
  end
end
