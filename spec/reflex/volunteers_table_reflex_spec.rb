# frozen_string_literal: true

require_relative "./reflex_helper"

RSpec.describe VolunteersTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_volunteers_path) }

  describe "#sort" do
    before do
      create(:volunteer, first_name: "Tyler", last_name: "Gottlieb", status: :active)
      create(:volunteer, first_name: "Victor", last_name: "Volunteer", status: :active)
      create(:volunteer, first_name: "Morgan", last_name: "Wiegand", status: :inactive)
      create(:volunteer, first_name: "Spencer", last_name: "Morar", status: :inactive)
    end

    it_behaves_like "sortable table", "status", User.all, "admin/volunteers/_volunteers_table"

    it_behaves_like "sortable table", "first_name", User.all, "admin/volunteers/_volunteers_table"

    it_behaves_like "sortable table", "last_name", User.all, "admin/volunteers/_volunteers_table"

    it_behaves_like "filterable table", "first_name", "e", {}, User.all, "admin/volunteers/_volunteers_table", "first_name ILIKE '%e%'"

    it_behaves_like "filterable table", "last_name", "g", {"first_name" => 'e'}, User.all, "admin/volunteers/_volunteers_table", "first_name ILIKE '%e%' and last_name ILIKE '%g%'"

    it_behaves_like "filterable table", "status", "0", {"first_name" => 'e'}, User.all, "admin/volunteers/_volunteers_table", "first_name ILIKE '%e%' and status=0"
  end
end
