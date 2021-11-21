# frozen_string_literal: true

require_relative "./reflex_helper"

RSpec.describe VolunteersTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_volunteers_path) }

  describe "#sort" do
    before do
      2.times do
        create(:volunteer, status: :active)
        create(:volunteer, status: :inactive)
      end
    end

    it_behaves_like "sortable table", "status", User.all, "admin/volunteers/_volunteers_table"

    it_behaves_like "sortable table", "first_name", User.all, "admin/volunteers/_volunteers_table"

    it_behaves_like "sortable table", "last_name", User.all, "admin/volunteers/_volunteers_table"
  end
end
