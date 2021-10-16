require "rails_helper"

RSpec.describe "/admin/tickets", type: :request do
  let(:current_user) { create(:user, role: :admin) }

  before(:each) do
    sign_in current_user
  end

  let(:valid_attributes) do
    attributes_for(:support_ticket, requestor_id: create(:user).id)
  end

  let(:invalid_attributes) do
    attributes_for(:support_ticket, requestor_id: nil, description: "")
  end

  describe "GET /index" do
    context "with format csv" do
      it "generates the csv file" do
        travel_to(Date.new(2021, 10, 14)) do
          create(:support_ticket, requestor: create(:volunteer, first_name: "Adam", last_name: "Lee"), survey_response: create(:survey_response, student: create(:student, first_name: "Jack", last_name: "Scott")), description: "Harum sed quas tempora.", status: :active)
          create(:support_ticket, requestor: create(:volunteer, first_name: "Olga", last_name: "Gray"), survey_response: nil, description: "Nihil amet id odit.", status: :closed)

          get admin_tickets_url, params: {format: :csv}

          expect(response.header["Content-Type"]).to include "text/csv"
          expect(response.headers["Content-Disposition"]).to include "attachment; filename=\"support-tickets-2021-10-14.csv\""
          expect(response.body).to eq <<~CSV
            "Requestor","Student","Created At","Description","Status"
            "Adam Lee","Jack Scott","2021-10-14 00:00:00 UTC","Harum sed quas tempora.","active"
            "Olga Gray","","2021-10-14 00:00:00 UTC","Nihil amet id odit.","closed"
          CSV
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates an admin Support Ticket", :aggregate_failures do
        expect do
          post admin_tickets_path, params: {support_ticket: valid_attributes}
        end.to change(SupportTicket, :count).by(1)
        expect(SupportTicket.last.category).to eq "admin"
      end

      it "redirects to support tickets index" do
        post admin_tickets_url, params: {support_ticket: valid_attributes}
        expect(response).to redirect_to(admin_tickets_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new support ticket" do
        expect do
          post admin_tickets_url, params: {support_ticket: invalid_attributes}
        end.to change(SupportTicket, :count).by(0)
      end

      it "renders a successful response" do
        post admin_tickets_url, params: {support_ticket: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "POST id/resolve" do
    subject(:support_ticket) { create(:support_ticket) }

    it "closes the support ticket" do
      freeze_time do
        post resolve_admin_ticket_url(support_ticket)

        expect(support_ticket.reload).to be_closed
        expect(support_ticket.closer).to eq current_user
        expect(support_ticket.closed_at).to eq Time.current
      end
    end
  end
end
