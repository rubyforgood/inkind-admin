SupportTicket.destroy_all

SupportTicket.create!(
  requestor: User.find_by(role: :volunteer),
  description: "Student needs a new backpack.",
  survey_response: SurveyResponse.first,
  status: :active
)

SupportTicket.create!(
  requestor: User.find_by(role: :volunteer),
  description: "Student needs a new pair of sneakers.",
  survey_response: SurveyResponse.last,
  status: :closed,
  closed_at: Time.zone.now + 3.hours,
  closer: User.find_by(role: :admin),
  closer_notes: "We sent the student a new pair of sneakers."
)

puts "Created 2 support tickets"
