# frozen_string_literal: true

require_relative "./reflex_helper"

RSpec.describe TicketsTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_tickets_path) }

  describe "#sort" do
    before do
      2.times do
        create(:support_ticket, status: :active)
        create(:support_ticket, status: :closed)
      end
    end

    it_behaves_like "sortable table", "created_at",
      SupportTicket.left_outer_joins(:requestor, survey_response: {student: {active_student_staff_assignment: :staff}}), "admin/tickets/_tickets_table"
    it_behaves_like "sortable table", "users.first_name",
      SupportTicket.left_outer_joins(:requestor, survey_response: {student: {active_student_staff_assignment: :staff}}), "admin/tickets/_tickets_table"
    it_behaves_like "sortable table", "students.last_name",
      SupportTicket.left_outer_joins(:requestor, survey_response: {student: {active_student_staff_assignment: :staff}}), "admin/tickets/_tickets_table"
    it_behaves_like "sortable table", "staffs_student_staff_assignments.last_name",
      SupportTicket.left_outer_joins(:requestor, survey_response: {student: {active_student_staff_assignment: :staff}}), "admin/tickets/_tickets_table"
    it_behaves_like "sortable table", "category",
      SupportTicket.left_outer_joins(:requestor, survey_response: {student: {active_student_staff_assignment: :staff}}), "admin/tickets/_tickets_table"
  end
end
