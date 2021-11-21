# frozen_string_literal: true

require_relative "./reflex_helper"

RSpec.describe AdminsTableReflex, type: :reflex do
  let(:reflex) { build_reflex(url: admin_admin_users_path) }

  describe "#sort" do
    before do
      2.times do
        create(:admin, status: :active)
        create(:admin, status: :inactive)
      end
    end

    it_behaves_like "sortable table", "status", User.all, "admin/admin_users/_admins_table"

    it_behaves_like "sortable table", "first_name", User.all, "admin/admin_users/_admins_table"

    it_behaves_like "sortable table", "last_name", User.all, "admin/admin_users/_admins_table"
  end
end
