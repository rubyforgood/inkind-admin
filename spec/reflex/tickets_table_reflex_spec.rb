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

    it_behaves_like "sortable table", "created_at", SupportTicket.all, "admin/tickets/_tickets_table"
    it_behaves_like "sortable table", "status", SupportTicket.all, "admin/tickets/_tickets_table"
  end
end
