# frozen_string_literal: true

require_relative "./reflex_helper"

RSpec.describe VolunteersTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_volunteers_path) }

  describe "#sort" do
    before do
      volunteer = create(:volunteer, first_name: "Tyler", last_name: "Gottlieb", status: :active)
      create(:volunteer, first_name: "Victor", last_name: "Volunteer", status: :active)
      create(:volunteer, first_name: "Morgan", last_name: "Wiegand", status: :inactive)
      create(:volunteer, first_name: "Spencer", last_name: "Morar", status: :inactive)

      student = create(:student)
      staff = create(:staff, first_name: "Addy", last_name: "Admin")
      staff2 = create(:staff, first_name: "test", last_name: "Test")
      create(:student_volunteer_assignment, student: student, volunteer: volunteer)
      create(:student_staff_assignment, student: student, staff: staff)
      create(:student_staff_assignment, student: student, staff: staff2)
    end

    it_behaves_like "sortable table", "status", User.where(role: :volunteer), "admin/volunteers/_volunteers_table"

    it_behaves_like "sortable table", "first_name", User.where(role: :volunteer), "admin/volunteers/_volunteers_table"

    it_behaves_like "sortable table", "last_name", User.where(role: :volunteer), "admin/volunteers/_volunteers_table"

    it_behaves_like "filterable table", "first_name", "e", {}, User.where(role: :volunteer), "admin/volunteers/_volunteers_table", "first_name ILIKE '%e%'"

    it_behaves_like "filterable table", "last_name", "g", {"first_name" => "e"}, User.where(role: :volunteer), "admin/volunteers/_volunteers_table", "first_name ILIKE '%e%' and last_name ILIKE '%g%'"

    it_behaves_like "filterable table", "status", "0", {"first_name" => "e"}, User.where(role: :volunteer), "admin/volunteers/_volunteers_table", "first_name ILIKE '%e%' and status=0"

    it_behaves_like "filterable table", "staff_names", "t", {"first_name" => "t"}, User.left_outer_joins(student_volunteer_assignments: {student: {active_student_staff_assignment: :staff}}), "admin/volunteers/_volunteers_table", "users.first_name ILIKE '%t%' and concat(staffs_student_staff_assignments.first_name, ' ', staffs_student_staff_assignments.last_name) ilike '%t%'"
  end
end
