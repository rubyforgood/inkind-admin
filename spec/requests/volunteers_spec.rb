require "rails_helper"

RSpec.describe "/admin/volunteers", type: :request do
  before(:each) do
    sign_in create(:user, role: :admin)
  end

  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    attributes_for(:user, email: "")
  end

  describe "GET /index" do
    context "with format csv" do
      it "generates the csv file" do
        travel_to(Date.new(2021, 10, 14)) do
          volunteer1 = create(:volunteer, first_name: "Zion", last_name: "Vandervort", email: "volunteer-1@example.edu", status: :inactive)
          create(:support_ticket, requestor: volunteer1)
          create(:support_ticket, requestor: volunteer1)

          volunteer2 = create(:volunteer, first_name: "Sutton", last_name: "Faddel", email: "volunteer-2@example.edu")

          create(:survey_response, volunteer: volunteer2, meeting_duration: build(:meeting_duration))
          create(:survey_response, volunteer: volunteer2, meeting_duration: build(:meeting_duration))
          create(:survey_response, volunteer: volunteer2, meeting_duration: nil)

          create(:support_ticket, requestor: volunteer2)

          get admin_volunteers_url, params: { format: :csv }

          expect(response.header["Content-Type"]).to include "text/csv"
          expect(response.headers["Content-Disposition"]).to include "attachment; filename=\"volunteers-2021-10-14.csv\""
          expect(response.body).to eq <<~CSV
            "Name","Email","Phone","Status","Last Seeen","Total Surveys Completed","Total Support Tickets Created"
            "Zion Vandervort","volunteer-1@example.edu","","inactive","","0","2"
            "Sutton Faddel","volunteer-2@example.edu","","active","2021-10-14 00:00:00 UTC","2","1"
          CSV
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Volunteer" do
        expect do
          post admin_volunteers_path, params: {user: valid_attributes}
        end.to change(User, :count).by(1)
      end

      it "redirects to the created volunteer" do
        post admin_volunteers_url, params: {user: valid_attributes}
        expect(response).to redirect_to(admin_volunteers_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new volunteer" do
        expect do
          post admin_volunteers_url, params: {user: invalid_attributes}
        end.to change(User, :count).by(0)
      end

      it "renders a successful response" do
        post admin_volunteers_url, params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        volunteer = User.create! valid_attributes
        patch admin_volunteer_url(volunteer), params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
end
