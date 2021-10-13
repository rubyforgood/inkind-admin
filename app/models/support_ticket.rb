class SupportTicket < ApplicationRecord
  belongs_to :requestor, class_name: "User",
                         foreign_key: :requestor_id
  belongs_to :closer, class_name: "User",
                      foreign_key: :closer_id,
                      optional: true
  belongs_to :survey_response, foreign_key: :survey_response_id,
                               optional: true

  enum status: {active: 0, closed: 1}

  validates :description, presence: true
end
