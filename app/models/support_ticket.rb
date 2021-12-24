class SupportTicket < ApplicationRecord
  include ExportToCsv

  belongs_to :requestor, class_name: "User",
                         foreign_key: :requestor_id,
                         inverse_of: :support_tickets
  belongs_to :closer, class_name: "User",
                      foreign_key: :closer_id,
                      optional: true
  belongs_to :survey_response, foreign_key: :survey_response_id,
                               optional: true

  validates :description, presence: true

  enum status: {active: 0, closed: 1}
  enum category: {survey_response: 0, admin: 1, contact_info: 2}

  def close!(closer, closer_notes: nil)
    return false if closed?

    update!(status: :closed, closer: closer, closer_notes: closer_notes, closed_at: Time.current)
  end

  def category_s
    ticket_types = {"survey_response" => "Support",
                    "admin" => "Admin",
                    "contact_info" => "Contact"}
    ticket_types[category]
  end

  def status_s
    statuses = {"active" => "Resolve", "closed" => "Closed"}
    statuses[status]
  end
end
