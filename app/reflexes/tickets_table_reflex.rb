# frozen_string_literal: true

class TicketsTableReflex < ApplicationReflex
  include TableHelper

  def sort
    sort_records(records: SupportTicket.left_outer_joins(:requestor, survey_response: {student: {active_student_staff_assignment: :staff}}),
      columns: %w[created_at users.first_name students.last_name
        staffs_student_staff_assignments.last_name category])
  end

  private

  def partial
    "tickets_table"
  end
end
